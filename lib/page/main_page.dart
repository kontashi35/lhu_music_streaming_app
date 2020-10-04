import 'dart:math';
import 'dart:ui';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:just_audio/just_audio.dart';
import 'package:lhu/service/audio_player.dart';
import 'package:lhu/widget/progressbar.dart';
import 'package:rxdart/rxdart.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AudioServiceWidget(child: StackBuilder(),),
    );
  }
}


class StackBuilder extends StatefulWidget {
  StackBuilder({Key key}) : super(key: key);


  _StackBuilderState createState() => _StackBuilderState();
}

class _StackBuilderState extends State<StackBuilder>
    with TickerProviderStateMixin {
  AnimationController paneController;
  AnimationController playPauseController;
  AnimationController songCompletedController;
  Animation<double> paneAnimation;
  Animation<double> albumImageAnimation;
  Animation<double> albunImageBlurAnimation;
  Animation<Color> songsContianerColorAnimation;
  Animation<Color> songsContianerTextColorAnimation;
  Animation<double> songCompletedAnimation;

  bool isAnimCompleted = false;
  bool isSongPlaying = false;

  double songCompleted = 0.0;
  double circleRadius = 5.0;


  /// Tracks the position while the user drags the seek bar.
  final BehaviorSubject<double> _dragPositionSubject =
  BehaviorSubject.seeded(null);

  @override
  void initState() {
    super.initState();

    paneController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    songCompletedController =
    AnimationController(vsync: this, duration: Duration(seconds: 360))
      ..addListener(() {
        setState(() {
          songCompleted = songCompletedAnimation.value;
        });
      });
    paneAnimation = Tween<double>(begin: -300, end: 0.0)
        .animate(CurvedAnimation(parent: paneController, curve: Curves.easeIn));
    albumImageAnimation = Tween<double>(begin: 1.0, end: 0.5)
        .animate(CurvedAnimation(parent: paneController, curve: Curves.easeIn));
    albunImageBlurAnimation = Tween<double>(begin: 0.0, end: 10.0)
        .animate(CurvedAnimation(parent: paneController, curve: Curves.easeIn));
    songsContianerColorAnimation =
        ColorTween(begin: Colors.black87, end: Colors.white.withOpacity(0.5))
            .animate(paneController);
    songsContianerTextColorAnimation =
        ColorTween(begin: Colors.white, end: Colors.black87)
            .animate(paneController);

    playPauseController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    songCompletedAnimation =
        Tween<double>(begin: 0.0, end: 400).animate(songCompletedController);

//    AudioService.start(
//      backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint,
//      androidNotificationChannelName: 'Audio Service Demo',
//      // Enable this if you want the Android service to exit the foreground state on pause.
//      //androidStopForegroundOnPause: true,
//      androidNotificationColor: 0xFF2196f3,
//      androidNotificationIcon: 'mipmap/ic_launcher',
//      androidEnableQueue: true,
//    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: paneController,
      builder: (BuildContext context, widget) {

        return stackBody(context);
      },
    );
  }

  //=====================Song Function==========================

  /// Encapsulate all the different data we're interested in into a single
  /// stream so we don't have to nest StreamBuilders.
  Stream<ScreenState> get _screenStateStream =>
      Rx.combineLatest3<List<MediaItem>, MediaItem, PlaybackState, ScreenState>(
          AudioService.queueStream,
          AudioService.currentMediaItemStream,
          AudioService.playbackStateStream,
              (queue, mediaItem, playbackState) =>
              ScreenState(queue, mediaItem, playbackState));



  Widget positionIndicator(MediaItem mediaItem, PlaybackState state) {
    double seekPos;
    return StreamBuilder(
      stream: Rx.combineLatest2<double, double, double>(
          _dragPositionSubject.stream,
          Stream.periodic(Duration(milliseconds: 200)),
              (dragPosition, _) => dragPosition),
      builder: (context, snapshot) {
        double position =
            snapshot.data ?? state.currentPosition.inMilliseconds.toDouble();
        double duration = mediaItem?.duration?.inMilliseconds?.toDouble();
        return Column(
          children: [
            if (duration != null)
              Slider(
                min: 0.0,
                max: duration,
                value: seekPos ?? max(0.0, min(position, duration)),
                onChanged: (value) {
                  _dragPositionSubject.add(value);
                },
                onChangeEnd: (value) {
                  AudioService.seekTo(Duration(milliseconds: value.toInt()));
                  // Due to a delay in platform channel communication, there is
                  // a brief moment after releasing the Slider thumb before the
                  // new position is broadcast from the platform side. This
                  // hack is to hold onto seekPos until the next state update
                  // comes through.
                  // TODO: Improve this code.
                  seekPos = value;
                  _dragPositionSubject.add(null);
                },
              ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${getCurrentTime(state.currentPosition.inSeconds)}"),
                  Text("${getCurrentTime(mediaItem?.duration?.inSeconds)}")
                ],
              ),
            ),
          ],
        );
      },
    );
  }
  //====================Song Function=====================================

  Widget stackBody(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        FractionallySizedBox(
          alignment: Alignment.topCenter,
          heightFactor: albumImageAnimation.value,
          child:
          //Todo Song Cover body
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: ExactAssetImage('assets/mm.jpg'),
                    fit: BoxFit.cover)),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: albunImageBlurAnimation.value,
                  sigmaY: albunImageBlurAnimation.value),
              child: Container(
                color: Colors.white.withOpacity(0.0),
              ),
            ),
          ),
        ),
        songContainer(context)
      ],
    );
  }

  animationInit() {
    if (isAnimCompleted) {
      paneController.reverse();
    } else {
      paneController.forward();
    }
    isAnimCompleted = !isAnimCompleted;
  }

  playSong(bool playing) {

    if (playing) {
      playPauseController.reverse();
      songCompletedController.reverse();
      AudioService.pause();
    } else {
      playPauseController.forward();
      songCompletedController.forward();
      AudioService.play();
    }
    isSongPlaying = !isSongPlaying;
  }
  //Song container ie al button and progress
  Widget songContainer(BuildContext context) {
    return StreamBuilder<ScreenState>(
      stream: _screenStateStream,
      builder: (context, snapshot) {
        final screenState = snapshot.data;
        final queue = screenState?.queue;
        final mediaItem = screenState?.mediaItem;
        final state = screenState?.playbackState;
        final processingState =
            state?.processingState ?? AudioProcessingState.none;
        final playing = state?.playing ?? false;
        return Positioned(
          bottom: paneAnimation.value,
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              var drag = details.primaryDelta / MediaQuery.of(context).size.height;
              paneController.value = paneController.value - 3 * drag;
              if (paneController.value >= 0.5) {
                paneController.fling(velocity: 1);
              } else {
                paneController.fling(velocity: -1);
              }
            },
            child: Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
                color: songsContianerColorAnimation.value,
              ),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (processingState == AudioProcessingState.none) ...[
                    RaisedButton(
                      child: Text('Play All'),
                      onPressed: () {
                        AudioService.start(
                          backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint,
                          androidNotificationChannelName: 'Audio Service Demo',
                          // Enable this if you want the Android service to exit the foreground state on pause.
                          //androidStopForegroundOnPause: true,
                          androidNotificationColor: 0xFF2196f3,
                          androidNotificationIcon: 'mipmap/ic_launcher',
                          androidEnableQueue: true,
                        );
                      },
                    ),
                  ]
                  else ...[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Now Playing",
                        style: prefix0.TextStyle(
                            color: songsContianerTextColorAnimation.value),
                      ),
                    ),
                    Text(
                      mediaItem?.title != null?mediaItem.title:'Loading title.....',
                      style: prefix0.TextStyle(
                          color: songsContianerTextColorAnimation.value,
                          fontSize: 16.0),
                    ),
                    Text(
                      mediaItem?.artist!=null?mediaItem.artist:'Loading artist.....',
                      style: prefix0.TextStyle(
                          color: songsContianerTextColorAnimation.value,
                          fontSize: 12.0),
                    ),
                    positionIndicator(mediaItem, state),
                   /* Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: GestureDetector(
                        onHorizontalDragStart: (details) {
                          setState(() {
                            circleRadius = 7.0;
                          });
                        },
                        onHorizontalDragUpdate: (details) {
                          var drag = details.primaryDelta /
                              MediaQuery.of(context).size.height;
                          songCompletedController.value = songCompletedController.value + 2 * drag;
                        },
                        onHorizontalDragEnd: (details) {
                          setState(() {
                            circleRadius = 5.0;
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 30.0,
                          child: CustomPaint(
                            painter: ProgresBar(
                                progresBarColor:
                                songsContianerTextColorAnimation.value,
                                songCompleted: songCompleted,
                                circleRadius: circleRadius),
                          ),
                        ),
                      ),
                    ),*/
                    if (queue != null && queue.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(

                            icon: Icon(Icons.skip_previous,
                                size: 40.0,
                                color: songsContianerTextColorAnimation.value),
                            onPressed: mediaItem == queue.first
                          ? null
                              : AudioService.skipToPrevious,
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                playSong(playing);
                              },
                              child: AnimatedIcon(
                                icon: AnimatedIcons.play_pause,
                                progress: playPauseController,
                                color: songsContianerTextColorAnimation.value,
                                size: 40.0,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.skip_next,
                                size: 40.0,
                                color: songsContianerTextColorAnimation.value),
                            onPressed:mediaItem == queue.last
                                ? null
                                : AudioService.skipToNext,
                          ),
                        ],
                      ),
                    ),
                  ],


                  //Todo Song list here
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (BuildContext context, index) {
                        return Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 60.0,
                                width: 60.0,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: ExactAssetImage('assets/mm.jpg'),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Another Song Name",
                                    style: prefix0.TextStyle(
                                      color: songsContianerTextColorAnimation.value,
                                    )),
                                Text(" Singer Name  | 3:45",
                                    style: prefix0.TextStyle(
                                      color: songsContianerTextColorAnimation.value,
                                    ))
                              ],
                            )
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );

  }

  getCurrentTime(int inSeconds) {
    if(inSeconds!=null){
      var d = Duration(seconds:inSeconds);
      List<String> parts = d.toString().split(':');
      print(parts[0]);
      return '${parts[1].padLeft(2, '0')}:${parts[2].padLeft(2, '0').split('.')[0]}';
    }

  }
}

class ScreenState {
  final List<MediaItem> queue;
  final MediaItem mediaItem;
  final PlaybackState playbackState;

  ScreenState(this.queue, this.mediaItem, this.playbackState);
}
// NOTE: Your entrypoint MUST be a top-level function.
void _audioPlayerTaskEntrypoint() async {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

class SleeperInterruptedException {}


class Seeker {
  final AudioPlayer player;
  final Duration positionInterval;
  final Duration stepInterval;
  final MediaItem mediaItem;
  bool _running = false;

  Seeker(
      this.player,
      this.positionInterval,
      this.stepInterval,
      this.mediaItem,
      );

  start() async {
    _running = true;
    while (_running) {
      Duration newPosition = player.position + positionInterval;
      if (newPosition < Duration.zero) newPosition = Duration.zero;
      if (newPosition > mediaItem.duration) newPosition = mediaItem.duration;
      player.seek(newPosition);
      await Future.delayed(stepInterval);
    }
  }

  stop() {
    _running = false;
  }
}



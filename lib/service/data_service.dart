import 'package:audio_service/audio_service.dart';
class MediaLibrary {
  final _items = <MediaItem>[
    MediaItem(
      id: "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3",
      album: "Science Friday",
      title: "A Salute To Head-Scratching Science",
      artist: "Science Friday and WNYC Studios",
      duration: Duration(milliseconds: 5739820),
      artUri:
      "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
    MediaItem(
      id: "https://s3.amazonaws.com/scifri-segments/scifri201711241.mp3",
      album: "Science Friday",
      title: "From Cat Rheology To Operatic Incompetence",
      artist: "Science Friday and WNYC Studios",
      duration: Duration(milliseconds: 2856950),
      artUri:
      "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
    MediaItem(
      id: "https://firebasestorage.googleapis.com/v0/b/techtibetmusic.appspot.com/o/1579949292113__New%20Tibetan%20Song%202019%20by%20Norlha%20%E0%BD%A6%E0%BD%BA%E0%BD%98%E0%BD%A6%E0%BC%8B%E0%BD%80%E0%BE%B1%E0%BD%B2%E0%BC%8B%E0%BD%96%E0%BD%A6%E0%BE%B3%E0%BD%B4%E0%BC%8B%E0%BD%96%E0%BC%8D%20The%20Heart%20of%20Deceiver.mp3?alt=media&token=3f54d384-4704-4e52-92d2-18e29396c803",
      album: "Science Friday",
      title: "Test 1",
      artist: "Science Friday and WNYC Studios",
      duration: Duration(milliseconds: 2856950),
      artUri:
      "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
    MediaItem(
      id: "https://firebasestorage.googleapis.com/v0/b/techtibetmusic.appspot.com/o/1579422409491__y2mate.com%20-%20tibetan_new_song_phur_2017_anu_xRGTQaCbbnw.mp3?alt=media&token=23d936b4-4a99-4e5b-89f9-8edfb1944600",
      album: "Science Friday",
      title: "Test 2",
      artist: "Science Friday and WNYC Studios",
      duration: Duration(milliseconds: 2856950),
      artUri:
      "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    )
  ];

  List<MediaItem> get items => _items;
}
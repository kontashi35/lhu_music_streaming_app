import 'package:flutter/material.dart';
import 'package:lhu/page/main_page.dart';
import 'package:lhu/shared/common_uti.dart';
import 'package:lhu/shared/constant.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, CommonUtil.createRoute(MainPage()));
              },
              child: ListTile(
                leading: Icon(Icons.play_circle_filled,size: 44,),
                title: Text('All Songs'),
                subtitle: Text('39 songs'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.play_circle_filled,size: 44,),
              title: Text('Most played'),
              subtitle: Text('40 songs'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.play_circle_filled,size: 44,),
              title: Text('Local Mp3'),
              subtitle: Text('39 songs'),
              trailing: Icon(Icons.arrow_forward_ios),
            )
          ],
        ),
      ),
    );
  }
}

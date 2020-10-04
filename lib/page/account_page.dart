import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    var radio;
    var groupRadio;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text('Lhu Premium Subscription',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.cloud_download,color: Colors.green,),
                      Text('Unlimited download',style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                      Icon(Icons.add),
                      Icon(Icons.playlist_add_check,color: Colors.green,),
                      Text('Ad-free music',style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.all(5),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Radio(
                                  value: radio,
                                  onChanged: (value) {

                                  },
                                  groupValue: groupRadio,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Rs 20'),
                                    Chip(label: Text('Monthly'),)
                                  ],
                                ),
                                SizedBox(width: 15,)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Card(

                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Radio(
                                  value: radio,
                                  onChanged: (value) {

                                  },
                                  groupValue: groupRadio,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Rs 20'),
                                    Chip(label: Text('Monthly'),)
                                  ],
                                ),
                                SizedBox(width: 15,)
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: RaisedButton(
                        color: Colors.green,
                        onPressed: null,child: Text('Pay Now'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  Text('Lhu Music Preference',style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),),
                  SizedBox(
                    height: 10,
                  ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text('Music Languages',style: TextStyle(
                         fontSize: 16,
                     ),),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Text('English',style: TextStyle(color: Colors.blueAccent,fontSize: 16),),
                         SizedBox(width: 10,),
                         Icon(Icons.arrow_forward_ios)
                       ],
                     ),

                   ],
                 ),
                  SizedBox(height: 5,),
                  Divider(),
                  Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text('Streaming Quality',style: TextStyle(
                    fontSize: 16,
                  ),),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Text('Auto',style: TextStyle(color: Colors.blueAccent,fontSize: 16),),
                         SizedBox(width: 10,),
                         Icon(Icons.arrow_forward_ios)
                       ],
                     )

                   ],
                 )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

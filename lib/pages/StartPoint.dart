import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweter/utilites/constans.dart';

import 'RegisterPage.dart';
import 'loginPage.dart';

class StartPoint extends StatefulWidget {
  @override
  _StartPointState createState() => _StartPointState();
}

class _StartPointState extends State<StartPoint> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        gradient:LinearGradient(
          begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              mainLightBluColor,
              mainDarkBluColor,
              mainLightBluColor,
            ]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
            body:Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.twitter,size: 50,color: mainWhiteBluColor,),
                        Text("Twitter",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: mainWhiteBluColor),),

                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 120,
                    width: 200,
                    child: Text("See What Happing in The World Right now.",
                      style: TextStyle(fontSize: 25,color: mainWhiteBluColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Column(
                      children: [
                        FlatButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginPage()));
                        },
                            child: Row(
                              children: [
                                Text("Log in Twitter",style: TextStyle(fontSize: 20,color: mainWhiteBluColor),),
                                SizedBox(width: 10,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50.0),
                                  child: Container(
                                    height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: mainWhiteBluColor,
                                      ),
                                      child: Icon(Icons.arrow_forward_ios)),
                                ),
                              ],
                            ),),
                        SizedBox(height: 10,),
                        FlatButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>RegisterPage()));

                        },
                            child: Row(
                              children: [
                                Text("Create new account",style: TextStyle(fontSize: 20,color: mainWhiteBluColor),),
                                SizedBox(width: 10,),
                                Container(
                                  height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: mainWhiteBluColor.withOpacity(0.1),
                                      border: Border.all(
                                        color: mainWhiteBluColor,
                                      )
                                    ),
                                    child: Icon(Icons.arrow_forward_ios)),
                              ],
                            ),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}

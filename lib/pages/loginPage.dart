
import 'package:flutter/material.dart';
import 'package:tweter/Api/sharedprefs.dart';
import 'package:tweter/pages/RegisterPage.dart';
import 'package:tweter/utilites/constans.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'controlpage.dart';
import 'homPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailcontroll=TextEditingController();
  final _passwordcontroll=TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _emailcontroll.dispose();
    _passwordcontroll.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
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

        body:SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 60,),
                Container(
                  height: 350,
                  width: 300,
                  decoration: BoxDecoration(
                      color: mainWhiteBluColor,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Log in Your account ! ",style: TextStyle(fontSize: 20,color: mainBlackBluColor,fontWeight: FontWeight.bold),),
                        TextFormField(
                          controller: _emailcontroll,
                          decoration: InputDecoration(
                            hintText: "Enter Your Email",
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: _passwordcontroll,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Password",
                          ),
                        ),
                        SizedBox(height: 20,),
                        Center(
                            child: RaisedButton(onPressed: (){
                              loginfun();
                            },
                              child: Text("Login"),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),),

                        ),
                        SizedBox(height: 10,),
                        FlatButton(onPressed: (){},
                            child: Text("Forget Password?",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: mainBlackBluColor),)),
                        FlatButton(onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder: (_)=>RegisterPage()));
                        },
                            child: Text("If you don\'t have account,create one !",style: TextStyle(fontSize: 15,
                                color: mainBlackBluColor),)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ) ,
      ),
    );
  }
  Future loginfun()async{
    var response=await http.post(LOGIN_UR,body: {
      "identifier":_emailcontroll.text,
      "password":_passwordcontroll.text,

    });
    if(response.statusCode==200){
      var body=jsonDecode(response.body);
      SharedPrefs.savetoken(body["jwt"]);
      print(body["id"].toString());
      print("account Login corrected");
      print(response.body);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>NavigationControlPage()));

    }else{
      print("account not register");
    }

  }
}

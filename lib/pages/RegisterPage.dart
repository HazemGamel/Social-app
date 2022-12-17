// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tweter/Api/sharedprefs.dart';
import 'package:tweter/pages/controlpage.dart';
import 'package:tweter/pages/homPage.dart';
import 'package:tweter/utilites/constans.dart';

import 'loginPage.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //final formkey=GlobalKey<FormState>();
  final _usernamecontroler=TextEditingController();
  final _emailcontroler=TextEditingController();
  final _passwordamecontroler=TextEditingController();
  final _fulnamecontroler=TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _usernamecontroler.dispose();
    _emailcontroler.dispose();
    _passwordamecontroler.dispose();
    _fulnamecontroler.dispose();
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
                  height: 400,
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
                        Text("Create new account in Twitter! ",style: TextStyle(fontSize: 20,color: mainBlackBluColor,fontWeight: FontWeight.bold),),
                        TextFormField(
                          controller: _fulnamecontroler,
                          decoration: InputDecoration(
                            hintText: "FulName",
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: _usernamecontroler,
                          decoration: InputDecoration(
                            hintText: "UserName",
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: _emailcontroler,
                          decoration: InputDecoration(
                            hintText: "Email",
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: _passwordamecontroler,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Password",
                          ),
                        ),
                        SizedBox(height: 20,),
                        Center(
                          child: RaisedButton(onPressed: ()async{
                                //create account
                              registerfun();
                          },
                            child: Text("Register"),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),),

                        ),
                        SizedBox(height: 10,),
                        FlatButton(onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder: (_)=>LoginPage()));

                        },
                            child: Text("If you have account,login now.",style: TextStyle(fontSize: 15,
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
  Future registerfun()async{
    var response=await http.post(REGISTER_UR,body: {
      "username":_usernamecontroler.text,
      "email":_emailcontroler.text,
      "password":_passwordamecontroler.text,
      "fulname":_fulnamecontroler.text,
    });

      if(response.statusCode==200){
        try {
          var body = jsonDecode(response.body);
          //print(body["user"]["id"].toString());
          SharedPrefs.savetoken(body["jwt"]);
          print("account Register corrected");
          //print(response.body);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => NavigationControlPage()));
        }catch(e){
          print(e.toString());
        }
      }else{
        print("account not register");
      }


  }
}

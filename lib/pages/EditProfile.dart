import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tweter/Api/fetchData.dart';
import 'package:tweter/main.dart';
import 'package:tweter/models/usermodel.dart';
import 'package:tweter/pages/controlpage.dart';
import 'package:tweter/pages/profilepage.dart';
import 'package:tweter/utilites/constans.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _usrnamcontroller=TextEditingController();
  TextEditingController _fulnamecontroller=TextEditingController();
  TextEditingController _emailcontroller=TextEditingController();
  ProfileUserModel profileUserMode;
  FetchData _fetchData=FetchData();
  int myId;
  @override
  void initState() {
    // TODO: implement initState
    _fetchData.fetchtprofiledata().then((value) {
      print(value.username);
      _usrnamcontroller.text=value.username;
      _emailcontroller.text=value.email;
      _fulnamecontroller.text=value.fullname;
      myId=value.id;
    });
    //print(profileUserMode.username);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Edit Your Profile data"),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (_)=>NavigationControlPage()));
        },),
      ),
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text("Change your profile image ",
                   style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                 SizedBox(height: 10,),
                 Row(
                   children: [
                     Icon(Icons.camera_alt,color: Colors.blue,),
                     SizedBox(width: 30,),
                     Text("Save",style: TextStyle(color: mainLightBluColor,fontSize: 20),)
                   ],
                 ),
               ],
             ),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text("Change your bannar image ",
                   style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                 SizedBox(height: 10,),
                 Row(
                   children: [
                     Icon(Icons.camera_alt,color: Colors.blue,),
                     SizedBox(width: 30,),
                     Text("Save",style: TextStyle(color: mainLightBluColor,fontSize: 20),)
                   ],
                 ),
               ],
             ),
           ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 250,
                    child: TextFormField(
                      controller: _usrnamcontroller,
                      decoration: InputDecoration(
                        labelText: "UserName",
                        hintText: "update your name"
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 13.0),
                    child: FlatButton(onPressed: (){
                      fetchtprofiledata(myId.toString());
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("UserName Updated Seccess"),
                              actions: [
                                Center(
                                    child: Icon(Icons.done,size: 50,color: Colors.greenAccent,)),
                              ],
                            );
                          });


                    },
                        child:Text("Save",style: TextStyle(color: mainLightBluColor,fontSize: 20),)),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 250,
                    child: TextFormField(
                      controller: _fulnamecontroller,
                      decoration: InputDecoration(
                        labelText: "FulName",
                        hintText: "update your Fulname"
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 13.0),
                    child: FlatButton(onPressed: (){},
                        child:Text("Save",style: TextStyle(color: mainLightBluColor,fontSize: 20),)),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 250,
                    child: TextFormField(
                      controller: _emailcontroller,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "update your email"
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 13.0),
                    child: FlatButton(onPressed: (){},
                        child:Text("Save",style: TextStyle(color: mainLightBluColor,fontSize: 20),)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


   fetchtprofiledata(String id)async {
    final header={"Authorization":"Bearer"+" "+prefs.getString("token"),
    "Accept":"application/json"};
    http.Response response = await http.put("$UPDATE_UR" + "$id" , headers: header,
        body: {
      "username":_usrnamcontroller.text,
    });

    if (response.statusCode == 200) {
      print("Update data get success");


    }else{
      print(response.statusCode);
      print("error Update profile data");
    }
    return null;
  }
}



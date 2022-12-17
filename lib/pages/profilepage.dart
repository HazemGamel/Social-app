import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweter/Api/fetchData.dart';
import 'package:tweter/Api/sharedprefs.dart';
import 'package:tweter/models/usermodel.dart';
import 'package:tweter/pages/EditProfile.dart';
import 'package:tweter/pages/StartPoint.dart';
import 'package:tweter/utilites/constans.dart';

import '../main.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilePage> {
 // String myId=prefs.getString("myId");
  //int myId=prefs.getInt("myId");
  FetchData _fetchData =FetchData();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: FutureBuilder(
                future:   _fetchData.fetchtprofiledata(),
                builder: (context,snapshot){
                  switch(snapshot.connectionState){
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                      break;
                    case ConnectionState.none:
                      return Center(child: Text("Error in conection"));
                      break;
                    case ConnectionState.active:
                      return Center(child: CircularProgressIndicator());
                      break;
                    case ConnectionState.done:
                      ProfileUserModel userdata=snapshot.data;
                      return headerprofilemodel(userdata);
                      break;
                  }
                },
              ),
            ),

          ],
        )
      ),
    );
  }
  Widget Tweetdesginforprofile(String description,String image){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width ,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45),
                            image: DecorationImage(
                                image: NetworkImage(image,),fit: BoxFit.cover
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("@UserName",
                          style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: mainLightBluColor),),
                      )
                    ],
                  ),
                  SizedBox(width: 6,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width *0.6,
                        child: Text(description,style: TextStyle(fontSize: 15),)),
                  ),


                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width *0.95,
              child: Card(
                child: Image.network(image,fit: BoxFit.cover,),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                        height: 50,
                        width: 50,
                        child: FlatButton(onPressed: (){}, child: Icon(FontAwesomeIcons.heart))),
                    Text("12 Likes",style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                Row(
                  children: [
                    Container(
                        height: 50,
                        width: 50,
                        child: FlatButton(onPressed: (){}, child: Icon(FontAwesomeIcons.comment))),
                    Text("20 comment",style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
              ],
            ),
            Divider(thickness: 3,),
          ],
        ),
      ),
    );
  }

  Widget headerprofilemodel(ProfileUserModel userdata){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height *0.3,
            child: Image.network("https://cdn.pocket-lint.com/r/s/1200x/assets/images/151442-cameras-feature-stunning-photos-from-the-national-sony-world-photography-awards-2020-image1-evuxphd3mr.jpg",fit: BoxFit.cover,),
          ),
          Transform.translate(
            offset: Offset(20,30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      border: Border.all(color: mainWhiteBluColor,width: 3),
                      borderRadius: BorderRadius.circular(45),
                      image: DecorationImage(
                          image: NetworkImage("https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),fit: BoxFit.cover
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: FlatButton(onPressed: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_)=>EditProfile()));
                  }, child:Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: mainDarkBluColor),
                          color: mainWhiteBluColor
                      ),
                      child: Center(child: Text("Edit Profile",
                        style: TextStyle(color: mainLightBluColor),))),),
                )
              ],
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 30.0,left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userdata.username,style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold),),
            Text("@${userdata.fullname} ",style: TextStyle(fontSize: 16,color: Colors.grey),),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 250.0),
              child: Container(
                width: 80,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.redAccent.withOpacity(0.7),
                ),
                child: FlatButton(onPressed: (){
                  SharedPrefs.savetoken("");
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=>StartPoint()));
                }, child: Text("LogOut")),
              ),
            ),
            Text("My Tweets",style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold,color: mainDarkBluColor),),
            SizedBox(height: 10,),

            Container(
              height: MediaQuery.of(context).size.height *0.9,
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context,index){
                    return Tweetdesginforprofile('description fo profile',
                        "https://cdn.pocket-lint.com/r/s/1200x/assets/images/151442-cameras-feature-stunning-photos-from-the-national-sony-world-photography-awards-2020-image1-evuxphd3mr.jpg");
                  }),
            )
          ],
        ),
      ),
    ],
  );
  }
}
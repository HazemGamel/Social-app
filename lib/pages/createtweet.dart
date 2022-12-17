import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tweter/Api/fetchData.dart';
import 'package:tweter/models/usermodel.dart';
import 'package:tweter/pages/controlpage.dart';
import 'package:tweter/utilites/constans.dart';
import '../main.dart';

class CreateTweet extends StatefulWidget {
  @override
  _CreateTweetState createState() => _CreateTweetState();
}

class _CreateTweetState extends State<CreateTweet> {
  ProfileUserModel userdata;
  TextEditingController _tweetcontroller=TextEditingController();
  File _image;
  final piker=ImagePicker();

  Future getImage()async{
    final imagepiker=await piker.getImage(source: ImageSource.camera,
    maxHeight: 400,
    maxWidth: 400,
    imageQuality: 40
    );
   setState(() {
     if(imagepiker != null){
       _image=File(imagepiker.path);
     }else{
       print("No image selected");
     }
   });
  }
  Future getImagefromgallary()async{
    final imagepiker=await piker.getImage(source: ImageSource.gallery,
    maxWidth: 400,
    maxHeight: 400,
    imageQuality: 50
        );
   setState(() {
     if(imagepiker != null){
       _image=File(imagepiker.path);
     }else{
       print("No image selected");
     }
   });
  }
  @override
  void initState() {
    // TODO: implement initState
    FetchData().fetchtprofiledata().then((value) {
      setState(() {
        userdata=value;
      });
    });
    super.initState();
  }
  @override
  void dispose() {
    _tweetcontroller.dispose();

    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.clear,color: Colors.black,size: 30,),onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>NavigationControlPage()));

        },),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          FlatButton(onPressed: ()async{
            try{
              final header={"Authorization":"Bearer"+" "+prefs.getString("token"),
              "Accept":"application/json"};
              Response response;
              Dio dio= Dio();
              response =await dio.post("$TWEETS_UR",
                  data:await addtweet(_image,_tweetcontroller.text),options: Options(
                    headers: header,
                  ) );
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>NavigationControlPage()));

            }catch(e){
              print(e.toString());
            }
          }, child:Container(
            height: 30,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: mainLightBluColor
            ),
              child: Center(child: Text("Tweet",style: TextStyle(color: Colors.white),))),)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        image: DecorationImage(
                          image: NetworkImage("https://i.pinimg.com/originals/7f/38/90/7f3890be6fca11b74fcb556122256a79.jpg")
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width *0.7,
                      height: 100,
                      child: TextFormField(
                        controller: _tweetcontroller,
                        maxLines: 8,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "What is in your mind?",
                        ),

                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){
                    getImage();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Select Image from camera ",style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(width: 5,),
                      Icon(FontAwesomeIcons.camera),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                InkWell(
                  onTap: (){
                    getImagefromgallary();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Select Image from Gallary",style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(width: 5,),
                      Icon(FontAwesomeIcons.camera),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            _image ==null?Container():Container(
              width: 400,
               height: 200,
               child: Image.file(_image)),
          ],
        ),
      ),
    );
  }
  Future<FormData> addtweet(File image,String tweetdescription)async{
    var formatdata=FormData();
    formatdata.fields.add(MapEntry("data",'{"description":"$tweetdescription"}'),);
    if(_image != null){
      formatdata.files.add(MapEntry("files.image",
          await MultipartFile.fromFile(image.path,filename:"tweet.png")));
    }
    return formatdata;

  }
}

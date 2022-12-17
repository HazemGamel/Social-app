import 'dart:convert';

import 'package:tweter/models/tweetsmodel.dart';
import 'package:http/http.dart'as http;
import 'package:tweter/models/userimage.dart';
import 'package:tweter/models/usermodel.dart';
import 'package:tweter/utilites/constans.dart';
import 'package:tweter/main.dart';
class FetchData{

 final header={"Authorization":"Bearer"+" "+prefs.getString("token")};
 Future<List<TweetModel>> fetchtweets()async {

   http.Response response = await http.get(TWEETS_UR, headers: header);

   if (response.statusCode == 200) {
     print("tweets get success");

  var body=jsonDecode(response.body);
  //print(body);
   var arrry=body['data'];
   List<TweetModel> tweets=[];
   for(var p in arrry){
     tweets.add(TweetModel.fromjson(p));
    // print( MAIN_UR+tweets[0].data.photo.Data.attributes.form.thu.url);
   }
   return tweets;
     }else{
       print(response.statusCode);
       print("error get tweets");
     }
      return null;
   }

 Future<List<TweetModel>> Searchtweets(String s)async {

   http.Response response = await http.get("$SEARSH_UR" + "$s" , headers: header);

   if (response.statusCode == 200) {
     print("tweets get success");

     var body=jsonDecode(response.body);
     print(body);
     var arrry=body['data'];
     List<TweetModel> tweets=[];
     for(var p in arrry){
       tweets.add(TweetModel.fromjson(p));
       // print( MAIN_UR+tweets[0].data.photo.Data.attributes.form.thu.url);
     }
     return tweets;
   }else{
     print(response.statusCode);
     print("error get tweets");
   }
   return null;
 }

 Future<ProfileUserModel> fetchtprofiledata()async {

   http.Response response = await http.get(PROFILE_UR, headers: header);

   if (response.statusCode == 200) {
     print("profile data get success");

     var body=jsonDecode(response.body);
    ProfileUserModel profileUserModel=ProfileUserModel.fromjson(body);
    print("pfof name ${profileUserModel.username}");
    return profileUserModel;

   }else{
     print(response.statusCode);
     print("error get profile data");
   }
   return null;
 }

 Future<UserImages> fetchtprofilImages(String id)async {
   http.Response response = await http.get("$PROFILE_IMAGE_UR"+id, headers: header);

   if (response.statusCode == 200) {
     print("profile data get success");
     fetchtprofiledata();
     var body=jsonDecode(response.body);
     UserImages userImages=UserImages.fromjson(body);
     print("images $body");
     return userImages;

   }else{
     print(response.statusCode);
     print("error get profile images");
   }
   return null;
 }
 }


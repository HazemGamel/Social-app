import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';


class TweetModel{
  int id,userid;
  UserData data;
  userpermission dataus;
  //attributes ttributes;
//String description;
//var image;

  TweetModel({ this.id,this.data,this.dataus,this.userid});

   factory TweetModel.fromjson(Map map){
     return TweetModel(
       id: map['id'],
      dataus: map["users_permissions_user"]!=null?userpermission.fromjson(map["users_permissions_user"]):null,
     // userid:map["users_permissions_user"]["data"]["id"],
      data:map['attributes'] != null?UserData.fromjson(map['attributes']):null,
      // ttributes: map['attributes'],
       //description:map['attributes']['attributes'],
      // image: map['image']['url']
     );
  }
}
class userpermission{
  datauser dataa;
  userpermission(this.dataa);
  userpermission.fromjson(Map<String,dynamic>map){
    dataa=map["data"]!=null?datauser.fromjson(map["data"]):null;
  }
}
class datauser{
  int uid;
  attributesuser attrbut;
  datauser(this.uid,this.attrbut);
  datauser.fromjson(Map<String,dynamic> map){
    uid=map["id"];
    attrbut =map["attributes"]!=null?attributesuser.fromjson(map["attributes"]):null;
  }
}

class attributesuser{
  String usernam;
  attributesuser(this.usernam);
  attributesuser.fromjson(Map<String,dynamic>map){
    usernam=map["username"];
  }
}


class UserData{
    String description;
      image photo;
    UserData(this.description,this.photo);

    UserData.fromjson(Map<String,dynamic> map){
      description=map['description'];
       photo=(map['image'] != null ? image.fromjson(map['image']):null);
    }

}

class image{

   data Data;
image(this.Data);
image.fromjson(Map<String,dynamic>map){
  Data=(map["data"]!= null?data.fromjson(map["data"]):null);

}

}
 class data{

  int id;
  Attributes attributes;
  data(this.id,this.attributes);
  data.fromjson(Map<String,dynamic>map){
    id=map['id'];
    attributes=(map['attributes'] !=null?Attributes.fromjson(map['attributes']):null);
  }


 }

class Attributes{
  formats form;
  Attributes(this.form);
  Attributes.fromjson(Map<String,dynamic> map){
    form=(map['formats'] != null ?formats.fromjson(map['formats']):null);
  }

}
class formats{
  thumbnail thu;
  formats.fromjson(Map<String,dynamic> map){
    thu= (map['thumbnail'] != null?thumbnail.fromjson(map['thumbnail']):null);
  }
}

class thumbnail{
  String url;
  thumbnail(this.url);
  thumbnail.fromjson(Map<String,dynamic> map){
    url=map['url'];

  }
}
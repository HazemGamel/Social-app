class UserImages{
  int id;
  String image;
  UserImages(this.id,this.image);
  UserImages.fromjson(Map<String,dynamic>map){
    id=map["id"];
    image=map["url"];
  }
}
class ProfileUserModel{
  int id;
  String username,fullname,email;
  ProfileUserModel(this.id,this.username,this.fullname,this.email);
  ProfileUserModel.fromjson(Map<String,dynamic>map){
    id=map["id"];
    username=map["username"];
    fullname=map["fulname"];
    email=map["email"];
  }
}
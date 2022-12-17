import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweter/Api/fetchData.dart';
import 'package:tweter/Api/sharedprefs.dart';
import 'package:tweter/models/usermodel.dart';
import 'package:tweter/pages/StartPoint.dart';
import 'package:tweter/pages/controlpage.dart';
import 'package:tweter/pages/homPage.dart';
SharedPreferences prefs;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   prefs=await SharedPreferences.getInstance();
  var token=prefs.getString('token');

  Widget _secrren;
  if(token==null||token==""){
    _secrren=StartPoint();
  }else{
    _secrren= NavigationControlPage();
  }
  runApp(MyApp(_secrren));
}

class MyApp extends StatefulWidget {
  final Widget secren;
   MyApp(this.secren);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FetchData _fetchData=FetchData();
  ProfileUserModel profileUserModel;
  @override
  void initState() {
    // TODO: implement initState
    _fetchData.fetchtprofiledata().then((value) {
      setState(() {
        profileUserModel=value;
        print("name = ${value.username}");
      });
    });
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tweeter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:widget.secren,
    );
  }
}



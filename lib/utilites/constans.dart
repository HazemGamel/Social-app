import 'package:flutter/material.dart';

final mainDarkBluColor= Color(0xff2766f6);
final mainLightBluColor= Color(0xff4ca1ee);
final mainWhiteBluColor= Color(0xfffefefb);
final mainBlackBluColor= Color(0xff404040);
//api
final MAIN_UR="http://192.168.1.8:1337";
final Uri  REGISTER_UR=Uri.parse(MAIN_UR+'/api/auth/local/register');
final Uri  LOGIN_UR=Uri.parse(MAIN_UR+'/api/auth/local');
final  Uri TWEETS_UR= Uri.parse(MAIN_UR+'/api/tweets?populate=*');

final  Uri PROFILE_UR= Uri.parse(MAIN_UR+'/api/users/me');
final  Uri UPDATE_UR= Uri.parse(MAIN_UR+'/api/users/');
final  Uri PROFILE_IMAGE_UR= Uri.parse(MAIN_UR+'/api/upload/files/');
final  Uri SEARSH_UR= Uri.parse(MAIN_UR+'api/tweets?description_contains= ');
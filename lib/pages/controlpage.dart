import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tweter/pages/homPage.dart';
import 'package:tweter/pages/notivigationpage.dart';
import 'package:tweter/pages/profilepage.dart';
import 'package:tweter/pages/searchpage.dart';


class NavigationControlPage extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<NavigationControlPage> {
  var _page = 0;
List<Widget> pages=[
  HomePage(),
  SearchPage(),
  NotinigationPage(),
  ProfilePage(),

];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
         body: pages[_page],
        bottomNavigationBar: SalomonBottomBar(
          unselectedItemColor: Colors.grey,
          currentIndex: _page,
          onTap: clicPage,
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              selectedColor: Colors.purple,
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: Icon(Icons.search),
              title: Text("Search"),
              selectedColor: Colors.pink,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: Icon(Icons.notification_important),
              title: Text("Notivigatins"),
              selectedColor: Colors.orange,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
              selectedColor: Colors.teal,
            ),
          ],
        ),

    );
  }

 void clicPage(int index) {
    setState(() {
      _page=index;
    });
  }
}
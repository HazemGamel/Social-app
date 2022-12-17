import 'package:flutter/material.dart';
import 'package:tweter/pages/controlpage.dart';
import 'package:tweter/utilites/constans.dart';

class commentPage extends StatefulWidget {
  @override
  _commentPageState createState() => _commentPageState();
}

class _commentPageState extends State<commentPage> {
  TextEditingController _comment=TextEditingController();
  String comment="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Comments"),
        centerTitle: true,
       leading:  InkWell(
           onTap: (){
             Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=>NavigationControlPage()));
           },
           child: Icon(Icons.arrow_back_ios,)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 210.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: mainLightBluColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      )
                    ),
                      child: Text("$comment",style:
                      TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                        textDirection: TextDirection.rtl,)),
                ),
              ],
            ),
            SizedBox(height: 400,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 250,
                    child: TextFormField(
                      controller: _comment,
                      decoration: InputDecoration(
                        hintText: "Write your comment..."
                      ),
                    ),
                  ),
                  Container(

                    child: IconButton(icon: Icon(Icons.send,color: mainDarkBluColor,
                      size: 40,),onPressed: (){
                      setState(() {
                        comment=_comment.text;
                      });
                    },),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

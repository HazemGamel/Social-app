import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweter/Api/fetchData.dart';
import 'package:tweter/main.dart';
import 'package:tweter/models/tweetsmodel.dart';
import 'package:tweter/models/usermodel.dart';
import 'package:tweter/pages/commentpage.dart';
import 'package:tweter/pages/createtweet.dart';
import 'package:tweter/utilites/constans.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FetchData _fetchData= FetchData();
 ProfileUserModel profileUserModel;
 int count=0;
 bool fave=false;
  @override
  void initState() {
    // TODO: implement initState
   _fetchData.fetchtprofiledata().then((value) {
     setState(() {
       profileUserModel=value;
       //print("name = ${value.username}");
     });
   });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Icon(FontAwesomeIcons.twitter,color: mainLightBluColor,size: 40,),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.auto_awesome,color:mainLightBluColor,size: 40,),
          ),
        ],

      ),
      body:SafeArea(
        child:SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: FutureBuilder(
                  future:   _fetchData.fetchtweets(),
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
                        List<TweetModel> tweets=snapshot.data.reversed.toList();
                        return Container(
                          height: 500,
                          child: ListView.builder(
                            itemCount: tweets==null?0:tweets.length,
                              itemBuilder:(context,index){
                              return Tweetdesgin(tweets[index]);
                              }),
                        );
                        break;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.marker),
        backgroundColor: mainLightBluColor,
        onPressed: (){
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=>CreateTweet()));
        },
      ),
    );
  }

  Widget Tweetdesgin(TweetModel tweet){
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
                               image: NetworkImage(MAIN_UR+tweet.data.photo.Data.attributes.form.thu.url,),fit: BoxFit.cover
                           )
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(top: 8.0),
                       child: Text("@Username",
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
                       child: Text(tweet.data.description,style: TextStyle(fontSize: 15),)),
                 ),


               ],
             ),
           ),
            Container(
              width: MediaQuery.of(context).size.width *0.95,
              //height: 300,
              child: Card(
                  child: Image.network(MAIN_UR+tweet.data.photo.Data.attributes.form.thu.url,fit: BoxFit.cover,)),
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
                        child: FlatButton(onPressed: (){
                           setState(() {
                             fave=!fave;
                             if(fave==false){
                               count=0;
                             }else if(fave==true){
                               count++;
                             }

                           });
                        },
                            child: Icon(FontAwesomeIcons.heart,color: fave?Colors.redAccent:Colors.grey,))),
                    Text("${count} Likes",style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                InkWell(
                  onTap: (){
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=>commentPage()));
                  },
                  child: Row(
                    children: [
                      Container(
                          height: 50,
                          width: 50,
                          child: FlatButton(onPressed: (){
                            setState(() {
                                count++;
                            });
                          }, child: Icon(FontAwesomeIcons.comment))),
                      Text("$count comment",style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                        height: 50,
                        width: 50,
                        child: FlatButton(onPressed: (){},
                            child: Icon(FontAwesomeIcons.share))),
                    Text("Share",style: TextStyle(fontWeight: FontWeight.bold),),
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
}

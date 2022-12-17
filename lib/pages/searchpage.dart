import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweter/Api/fetchData.dart';
import 'package:tweter/models/tweetsmodel.dart';
import 'package:tweter/utilites/constans.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FetchData _fetchData=FetchData();
  bool fave=false;
  int count=0;
  TextEditingController _search=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    //_fetchData.Searchtweets("s");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search about what you want "),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _search,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search now ",
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            Center(child: Container(
              height: 30,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),

                child: FlatButton(onPressed: (){}, child:Text("Search")))),
            SingleChildScrollView(
              child: Container(
                height: 500,
                child: FutureBuilder(
                  future: _fetchData.fetchtweets(),
                  builder: (context,snapshot){
                    List<TweetModel> tweet=snapshot.data;
                    return Container(
                      height: 500,
                      child: ListView.builder(
                        itemCount:tweet==null?0: tweet.length,
                          itemBuilder:(context,index){
                          return Tweetdesgin(tweet[index]);
                          } ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ) ,
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
              height: 250,
              child: Card(
                child: Image.network(MAIN_UR+tweet.data.photo.Data.attributes.form.thu.url,fit: BoxFit.cover,),
              ),
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
                Row(
                  children: [
                    Container(
                        height: 50,
                        width: 50,
                        child: FlatButton(onPressed: (){}, child: Icon(FontAwesomeIcons.comment))),
                    Text("20 comment",style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
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

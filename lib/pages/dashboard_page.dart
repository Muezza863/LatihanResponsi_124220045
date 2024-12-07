import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lat_responsi/pages/content_page.dart';

//import 'menu_page.dart';

class DashboardPage extends StatefulWidget {
  final String username;
  //Menerima username
  DashboardPage({required this.username});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Hai, ${widget.username}!',
          style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          //Background Color
          Container(
            color: Colors.grey,
          ),
          Column(
            children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContentPage(type: 'articles'),
                          ),
                        );
                      },
                      child: Card(
                          child: Row(
                            children: [
                              SizedBox(width: 10,),
                              Container(
                                width: 100,
                                height: 225,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/images/news.png'),
                                      fit: BoxFit.contain
                                  ),
                                ),
                              ),
                              SizedBox(width: 30,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("News", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                                    Text("Get an overview of the latest SpaceFlight news, from various sources!. Easily link your users to the right websites",
                                      softWrap: true,)
                                  ],
                                ),
                              ),
                              SizedBox(width: 20,)
                            ],
                          ),
                        ),
                      )
                    )
                 ),


              Center(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContentPage(type: 'blogs'),
                            ),
                          );
                        },
                        child: Card(
                          child: Row(
                            children: [
                              SizedBox(width: 10,),
                              Container(
                                width: 100,
                                height: 225,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/images/blog.png'),
                                      fit: BoxFit.contain
                                  ),
                                ),
                              ),
                              SizedBox(width: 30,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Blog", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                                    Text("Blogs often provide a more detailed overview of launches and missions. A must-have for the serious spaceflight enthusiast",
                                      softWrap: true,)
                                  ],
                                ),
                              ),
                              SizedBox(width: 20,)
                            ],
                          ),
                        ),
                      )
                  )
              ),

              Center(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContentPage(type: 'reports'),
                            ),
                          );
                        },
                        child: Card(
                          child: Row(
                            children: [
                              SizedBox(width: 10,),
                              Container(
                                width: 100,
                                height: 225,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/images/report.png'),
                                      fit: BoxFit.contain
                                  ),
                                ),
                              ),
                              SizedBox(width: 30,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Report", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                                    Text("Space stations and other missions often publish their data. With SNAPI, you can include it in your",
                                      softWrap: true,)
                                  ],
                                ),
                              ),
                              SizedBox(width: 20,)
                            ],
                          ),
                        ),
                      )
                  )
              ),
            ],
          ),
        ],
      )
    );
  }
}
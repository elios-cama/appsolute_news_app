// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:appsolute_news_app/models/article.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailNews extends StatefulWidget {
  final Article article;
  const DetailNews({required this.article, Key? key}) : super(key: key);

  @override
  State<DetailNews> createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  SharedPreferences? preferences;
  Future<void> initializePreference() async{
     preferences = await SharedPreferences.getInstance();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializePreference().whenComplete((){
       setState(() {});
     });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _launchURL() async {
    var url = widget.article.url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
    
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.article.title),
        actions: [
          GestureDetector(
            onTap: (){
              Share.share(widget.article.url);
            },
              child: Icon(
            Icons.share,
            color: Colors.white,
          ))
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: size.height / 4,
                    width: double.infinity,
                    child: widget.article.imageUrl != ""
                        ? Image.network(
                            widget.article.imageUrl,
                            fit: BoxFit.cover,
                          )
                        : Text("Image can't be loaded")),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  
                  width: double.infinity,
                  child: Text(
                    widget.article.description,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    widget.article.content,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: ElevatedButton(
                    onPressed: (){
                      _launchURL();
                    },
                    child: Text("Check the article on the web")
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

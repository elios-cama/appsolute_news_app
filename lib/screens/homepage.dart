// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:appsolute_news_app/models/article.dart';
import 'package:appsolute_news_app/screens/detail_screen.dart';
import 'package:appsolute_news_app/services/news_api.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Article>? newsList;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews().then((value) {
      setState(() {
        if (value.isNotEmpty) {
          newsList = value;
          isLoading = false;
        } else {
          print("list is empty");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Appsolute",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "News",
                  style: TextStyle(
                      color: Colors.blueAccent, fontStyle: FontStyle.italic),
                )
              ],
            ),
            backgroundColor: Colors.black,
          ),
          body: isLoading
              ? Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: size.height / 20,
                    width: size.width / 20,
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                        child: Container(
                      child: ListView.builder(
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return ArticleTile(size, context, newsList![index]);
                          }),
                    )),
                  ],
                )),
    );
  }
}

Widget ArticleTile(Size size, BuildContext context, Article article) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => DetailNews(
            article: article,
          )));
    },
    child: Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.only(bottom: 10, left: 5, right: 5),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3.0,
            ),
          ]),
      child: Column(
        
        children: [
          Container(
              height: size.height / 4,
              width: size.width / 1.15,
              alignment: Alignment.center,
              child: article.imageUrl != ""
                  ? ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Image.network(
                        article.imageUrl,
                        fit: BoxFit.cover,
                      ),
                  )
                  : Text("Image can't be loaded")),
          SizedBox(
            height: 8.0,
          ),
          Container(
            width: size.width / 1.1,
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              article.title,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            width: size.width / 1.1,
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              article.description,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );
}
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:appsolute_news_app/components/articleTile.dart';
import 'package:appsolute_news_app/models/article.dart';
import 'package:appsolute_news_app/screens/Saved_screen.dart';
import 'package:appsolute_news_app/services/news_api.dart';
import 'package:appsolute_news_app/services/search.dart';
import 'package:appsolute_news_app/services/sharedpref.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Article>? newsList;
  bool isLoading = true;
  bool _isFavorite = false;
  SharedPref prefs = SharedPref();
  Article testshare = Article(title: "title", imageUrl: "imageUrl", content: "content", description: "description", url: "url");
  @override
  void initState() {
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
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SavedArticles()),
                );
              },
              child: Icon(FontAwesomeIcons.heart, size: 20,)
            ),
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
                      color: Color(0xFF4361EE), fontStyle: FontStyle.italic),
                ),
              ],
            ),
            actions: [
              GestureDetector(
                /*onTap: () async{
                  prefs.read();
                  //Article test2 = Article.fromJson(await prefs.getListData('listArticles'));
                  List<String>? savedArticles = await prefs.getListData('listArticles');

                  if(savedArticles != null){
                    print(savedArticles);
                  }else{
                    print("no favorite yet");
                  }
                  },*/
                onTap: (){
                  showSearch(context: context, delegate: SearchArticles());
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(FontAwesomeIcons.search, size: 18,)
                ),
              ),
            ],
            backgroundColor: Colors.black,
          ),
          body: isLoading
              ? Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.black,
                      child: Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        ),
                    ),
                  ),
                ],
              )
              : Column(
                  children: [
                    Expanded(
                        child: Container(
                          color: Colors.black,
                      child: ListView.builder(
                          itemCount: newsList!.length,
                          itemBuilder: (context, index) {
                            return ArticleTiles(article: newsList![index]);
                          }),
                    )),
                  ],
                )),
    );
  }
}
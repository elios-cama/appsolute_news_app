// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:appsolute_news_app/models/article.dart';
import 'package:appsolute_news_app/providers/favorite.dart';
import 'package:appsolute_news_app/screens/Saved_screen.dart';
import 'package:appsolute_news_app/screens/detail_screen.dart';
import 'package:appsolute_news_app/services/news_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Article>? newsList;
  bool isLoading = true;
  bool _isFavorite = false;

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
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SavedArticles()),
                );
              },
              child: Icon(Icons.download),
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
                      color: Colors.blueAccent, fontStyle: FontStyle.italic),
                ),
              ],
            ),
            actions: [Icon(Icons.search)],
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

class ArticleTiles extends StatefulWidget {
  Article article;
  ArticleTiles({required this.article});

  @override
  _ArticleTilesState createState() => _ArticleTilesState();
}

class _ArticleTilesState extends State<ArticleTiles> {
  bool _isFavorite = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => DetailNews(
                  article: widget.article,
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
                child: widget.article.imageUrl != ""
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Stack(
                          children: [
                            Image.network(
                              widget.article.imageUrl,
                              fit: BoxFit.cover,
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isFavorite = !_isFavorite;
                                      _isFavorite
                                          ? context
                                              .read<FavoriteProvider>()
                                              .AddArticles(widget.article)
                                          : context
                                              .read<FavoriteProvider>()
                                              .RemoveArticles(widget.article);
                                      /*context
                                          .read<FavoriteProvider>()
                                          .AddArticles(widget.article);*/
                                    });
                                  },
                                  child: Icon(Icons.favorite_border_outlined,
                                      color: _isFavorite
                                          ? Colors.yellow
                                          : Colors.white)),
                            )
                          ],
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
                widget.article.title,
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
                widget.article.description,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class SavedArticlesTiles extends StatefulWidget {
  Article article;
  SavedArticlesTiles({required this.article});

  @override
  _SavedArticlesTilesState createState() => _SavedArticlesTilesState();
}

class _SavedArticlesTilesState extends State<SavedArticlesTiles> {

  @override
   Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => DetailNews(
                  article: widget.article,
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
                child: widget.article.imageUrl != ""
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Image.network(
                          widget.article.imageUrl,
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
                widget.article.title,
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
                widget.article.description,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
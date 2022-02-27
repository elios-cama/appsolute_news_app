// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:appsolute_news_app/components/savedArticleTile.dart';
import 'package:appsolute_news_app/providers/favorite.dart';
import 'package:appsolute_news_app/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SavedArticles extends StatefulWidget {
  const SavedArticles({ Key? key }) : super(key: key);

  @override
  _SavedArticlesState createState() => _SavedArticlesState();
}

class _SavedArticlesState extends State<SavedArticles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            centerTitle: true,
            
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Saved",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "News",
                  style: TextStyle(
                      color: Colors.blueAccent, fontStyle: FontStyle.italic),
                ),
              ],
            ),
            
            backgroundColor: Colors.black,
          ),
      body: ListView.builder(
        itemCount: context.watch<FavoriteProvider>().getList().length,
        itemBuilder: (context,index){
          return SavedArticlesTiles(article:context.watch<FavoriteProvider>().getList()[index] );
        },
        ),
    );
  }
}
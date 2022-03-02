// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable

import 'package:appsolute_news_app/models/article.dart';
import 'package:appsolute_news_app/screens/detail_screen.dart';
import 'package:flutter/material.dart';


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
        padding: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF03045E), Color(0xFF292E82)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
            
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 3.0,
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:appsolute_news_app/models/article.dart';
import 'package:flutter/material.dart';

class DetailNews extends StatelessWidget {
  final Article article;
  const DetailNews({required this.article, Key? key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
        final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(article.title),
        actions: [
          Icon(Icons.share, color: Colors.white,)
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
                  child: article.imageUrl != ""
                  ? Image.network(
                      article.imageUrl,
                      fit: BoxFit.cover,
                    )
                  : Text("Image can't be loaded")
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  height: size.height / 10,
                  width: double.infinity,
                  child: Text(
                    article.description,
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
                    article.content,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                     
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// ignore_for_file: prefer_const_constructors

import 'package:appsolute_news_app/components/articleTile.dart';
import 'package:appsolute_news_app/models/article.dart';
import 'package:appsolute_news_app/services/news_api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchArticles extends SearchDelegate {

  
  
  
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.delete))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    Future<List<Article>> newsList = getNewsQuery(query: query);
    return Column(
                  children: [
                    Expanded(
                        child: Container(
                          color: Colors.black,
                      child: FutureBuilder<List<Article>>(
                          future: newsList,
                          builder: (context, snapshot) {
                            var data = snapshot.data;
                            if(!snapshot.hasData){
                              return Center(child: CircularProgressIndicator(),);
                            }
                            return ListView.builder(
                            itemCount: data?.length,
                            itemBuilder: (context, index) {
                              return ArticleTiles(article: data![index]);
                            });
                          },
                          
                        
                      ),
                    )),
                  ],
                );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    
    return Column(
      children: [
        Expanded(

          child: Container(
            color: Colors.black,
            child: Center(
              child: Text('Search Articles by title' ,style: TextStyle(color: Colors.white),),
            ),
          ),
        ),
      ],
    );
  }
}

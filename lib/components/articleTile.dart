import 'package:appsolute_news_app/models/article.dart';
import 'package:appsolute_news_app/providers/favorite.dart';
import 'package:appsolute_news_app/screens/detail_screen.dart';
import 'package:appsolute_news_app/services/sharedpref.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ArticleTiles extends StatefulWidget {
  Article article;
  ArticleTiles({required this.article});

  @override
  _ArticleTilesState createState() => _ArticleTilesState();
}

class _ArticleTilesState extends State<ArticleTiles> {
  bool _isFavorite = false;
    SharedPref prefs = SharedPref();

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
                                      if(_isFavorite == false){
                                        context
                                              .read<FavoriteProvider>()
                                              .RemoveArticles(widget.article);
                                        prefs.remove();
                                      }else{
                                        context
                                              .read<FavoriteProvider>()
                                              .AddArticles(widget.article);
                                        prefs.save('article', widget.article);
                                      }
                                      
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
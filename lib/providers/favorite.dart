import 'package:appsolute_news_app/models/article.dart';
import 'package:flutter/widgets.dart';

class FavoriteProvider with ChangeNotifier{
   List _favoriteList = [];

   List getList() => _favoriteList;

   void AddArticles(Article article){
      _favoriteList.add(article);
      notifyListeners();
      
   }

   void RemoveArticles(Article article){
     _favoriteList.remove(article);
     
     notifyListeners();
   }


}
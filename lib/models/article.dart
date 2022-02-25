class Article {
  String title, imageUrl, content, description;

  Article(
      {required this.title,
      required this.imageUrl,
      required this.content,
      required this.description});


  factory Article.fromJson(Map<String, dynamic> jsonData){
    return Article(
      title: jsonData['title'] ?? "",
      imageUrl: jsonData['urlToImage']?? "",
      content: jsonData['content']?? "",
      description: jsonData['description']?? "",
    );
  }    
}

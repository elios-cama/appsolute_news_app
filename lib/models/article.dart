class Article {
  String title, imageUrl, content, description, url;

  Article(
      {required this.title,
      required this.imageUrl,
      required this.content,
      required this.description,
      required this.url
      });


  factory Article.fromJson(Map<String, dynamic> jsonData){
    return Article(
      title: jsonData['title'] ?? "",
      imageUrl: jsonData['urlToImage']?? "",
      content: jsonData['content']?? "",
      description: jsonData['description']?? "",
      url: jsonData['url']?? "",
    );
  }   

  Map<String, dynamic> toJson() => {
  'title': title,
  'imageUrl': imageUrl,
  'content': content,
  'description': description,
  'url' : url
}; 
}

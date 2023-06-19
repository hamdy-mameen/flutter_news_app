class Article {
  final int? id;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;
  Article(
      {this.id,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.content,
      this.publishedAt});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        id: json['id'],
        author: json['author'],
        title: json['title'],
        description: json['description'],
        url: json['url'],
        urlToImage: json['urlToImage'],
        content: json['content'],
        publishedAt: json['publishedAt']);
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'author': author,
        'title': title,
        'description': description,
        'url': url,
        'urlToImage': urlToImage,
        'content': content,
        'publishedAt': publishedAt
      };
}

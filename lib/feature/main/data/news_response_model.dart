import 'package:blocsevendays/feature/main/domain/main_entity.dart';

class NewsResponseModel {
  final String? status;
  final List<ArticleModel>? articles;

  NewsResponseModel({
    required this.status,
    this.articles,
  });

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) {
    final status = json['status'] as String;
    final articles = json['articles'] as List<ArticleModel>?;
    return NewsResponseModel(
      status: status,
      articles: articles,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'articles': articles,
  };

}

class ArticleModel {
  final String? title;
  final String? author;
  final String? publishedAt;

  ArticleModel({
    required this.title,
    required this.author,
    required this.publishedAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    final title = json['title'] as String;
    final author = json['author'] as String;
    final publishedAt = json['publishedAt'] as String;
    return ArticleModel(
      title: title,
      author: author,
      publishedAt: publishedAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'author': author,
    'publishedAt': publishedAt,
  };

  ArticleEntity toEntity() => ArticleEntity(
    title: title ?? "",
    author: author ?? "",
    publishedAt: publishedAt ?? "",
  );



}


/*
https://newsapi.org/v2/everything?q=tesla&from=2025-09-08&sortBy=publishedAt&apiKey=
{
"status" : "ok",
"totalResults": "7646",
"articles" : [
      {
          "title": "Title",
          "description": "Desc",
          "publishedAt": "2025-10-08T05:50:57Z"
      }
]
}
 */
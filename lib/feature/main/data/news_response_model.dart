import 'package:blocsevendays/core/utils/logger.dart';
import 'package:blocsevendays/feature/main/domain/article_entity.dart';
import '../domain/news_entity.dart';

class NewsResponseModel {
  final String? status;
  final List<ArticleModel>? articles;

  NewsResponseModel({
    required this.status,
    this.articles,
  });

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) {
    final articlesList = json['articles'] as List?;

    final parsedArticles = articlesList
        ?.map((articleJson) => ArticleModel.fromJson(articleJson))
        .toList() ?? [];

    // AppLogger.debug("SHITAB: "+ parsedArticles!.length.toString());

    return NewsResponseModel(
      status: json['status'] as String?,
      articles: parsedArticles,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'articles': articles?.map((article) => article.toJson()).toList(),
  };

  NewsEntity toEntity() => NewsEntity(
    status: status ?? "",
    articles: articles?.map((article) => article.toEntity()).toList() ?? [],
  );
}

class ArticleModel {
  final String? title;
  final String? author;
  final String? publishedAt;

  ArticleModel({
    this.title,
    this.author,
    this.publishedAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] as String?,
      author: json['author'] as String?,
      publishedAt: json['publishedAt'] as String?,
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
import 'package:blocsevendays/feature/main/domain/article_entity.dart';

class NewsEntity {
  final String status;
  final List<ArticleEntity> articles;

  NewsEntity({
    required this.status,
    required this.articles,
  });
}
import 'package:blocsevendays/feature/main/domain/article_entity.dart';

import '../../../core/exceptions/app_exceptions.dart';
import 'package:dart_either/dart_either.dart';

abstract class NewsRepository {
  Future<Either<AppException, List<ArticleEntity>>> getArticles(
        String q,
        String from,
        String sortBy,
        String apiKey,
      );
}
import 'package:blocsevendays/feature/main/domain/article_entity.dart';
import 'package:blocsevendays/feature/main/domain/news_repository.dart';
import 'package:dart_either/dart_either.dart';
import '../../../../core/exceptions/app_exceptions.dart';

class GetNewsUseCase {
  final NewsRepository _repository;

  GetNewsUseCase(this._repository);

  Future<Either<AppException, List<ArticleEntity>>> call(
      String q,
      String from,
      String sortBy,
      String apiKey,
      ) async {
    return await _repository.getArticles(q, from, sortBy, apiKey);
  }
}
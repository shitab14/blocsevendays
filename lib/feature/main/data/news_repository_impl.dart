import 'package:blocsevendays/core/exceptions/app_exceptions.dart';
import 'package:blocsevendays/core/utils/logger.dart';
import 'package:blocsevendays/feature/main/domain/article_entity.dart';
import 'package:dart_either/dart_either.dart';
import 'package:dart_either/src/dart_either.dart';
import '../../../core/exceptions/exception_handler.dart';
import '../domain/news_repository.dart';
import 'news_remote_datasource.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource _remoteDataSource;

  NewsRepositoryImpl(this._remoteDataSource,);

  @override
  Future<Either<AppException, List<ArticleEntity>>> getArticles(
      String q,
      String from,
      String sortBy,
      String apiKey,
      ) async {
    try {
      final newsDataModel = await _remoteDataSource.getNews(q, from, sortBy, apiKey);

      return Right(newsDataModel.toEntity().articles);
    } on AppException catch (e) {
      return Left(ExceptionHandler.handleException(e));
    }

  }

}
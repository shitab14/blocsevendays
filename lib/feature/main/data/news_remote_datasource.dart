import 'package:blocsevendays/core/api/api_client.dart';
import 'package:blocsevendays/core/utils/logger.dart';
import 'package:blocsevendays/feature/main/data/news_response_model.dart';
import '../../../../core/utils/constants.dart';

abstract class NewsRemoteDataSource {
  Future<NewsResponseModel> getNews(
        String q,
        String from,
        String sortBy,
        String apiKey,
      );
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final ApiClient _apiClient;

  NewsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<NewsResponseModel> getNews(
      String q,
      String from,
      String sortBy,
      String apiKey
      ) async {
    final response = await _apiClient.get(
      '/everything?q=$q&from=$from&sortBy=$sortBy&apiKey=$apiKey',
    );

    final results = response.data;
    // AppLogger.debug("SHITAB: "+ results.toString());

    return NewsResponseModel.fromJson(results);
  }

}
import 'package:blocsevendays/core/api/key_client.dart';
import 'package:blocsevendays/core/utils/logger.dart';
import '../../../../core/utils/constants.dart';
import 'key_model.dart';

abstract class KeyRemoteDataSource {
  Future<KeyModel> getKey();
}

class KeyRemoteDataSourceImpl implements KeyRemoteDataSource {
  final KeyClient _apiClient;

  KeyRemoteDataSourceImpl(this._apiClient);

  @override
  Future<KeyModel> getKey() async {
    final response = await _apiClient.get(
      '/keys.json',
    );

    final results = response.data;
    return KeyModel.fromJson(results);
  }

}
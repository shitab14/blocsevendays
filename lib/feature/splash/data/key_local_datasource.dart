import 'package:blocsevendays/core/localdata/sharedpreference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../core/utils/constants.dart';
import 'key_model.dart';

abstract class KeyLocalDataSource {
  Future<KeyModel> getKey();
  Future<void> saveKey(KeyModel keyModel);
}

class KeyLocalDataSourceImpl implements KeyLocalDataSource {

  @override
  Future<KeyModel> getKey() async {
    final results = await SharedPreferencesHelper.getValue<String>(AppConstants.newsKey);
    return KeyModel(key: results);
      // results.map((e) => KeyModel.fromJson(e));
  }

  @override
  Future<void> saveKey(KeyModel key) async {
    await SharedPreferencesHelper.setValue<String>(AppConstants.newsKey, key.key ?? "");
  }

}
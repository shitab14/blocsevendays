import 'package:blocsevendays/core/exceptions/exception_handler.dart';
import 'package:blocsevendays/core/utils/logger.dart';
import 'package:blocsevendays/feature/splash/data/key_model.dart';
import 'package:dart_either/dart_either.dart';
import '../../../../core/exceptions/app_exceptions.dart';
import 'package:entity/entity.dart';
import '../domain/key_entity.dart';
import '../domain/key_repository.dart';
import 'key_local_datasource.dart';
import 'key_remote_datasource.dart';


class KeyRepositoryImpl implements KeyRepository {
  final KeyRemoteDataSource _remoteDataSource;
  final KeyLocalDataSource _localDataSource;

  KeyRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<AppException, KeyEntity>> getKey() async {
    try {
      final localKeyModel = await _localDataSource.getKey();
      if(localKeyModel.key == null) {
        // Try to fetch from remote
        AppLogger.debug("SHITAB: Got Key from REMOTE");
        final remoteKeyModel = await _remoteDataSource.getKey();
        await _localDataSource.saveKey(remoteKeyModel);
        return Right(remoteKeyModel.toEntity());

      } else {
        // Got from local
        AppLogger.debug("SHITAB: Got Key from LOCAL");

        return Right(localKeyModel.toEntity());
      }

    } on AppException catch (e) {
      ExceptionHandler.handleException(e);

      return Left(e);
    }
  }

}

extension KeyModelX on KeyModel {
  KeyEntity toEntity() => KeyEntity(
    key: key ?? "",
  );
}


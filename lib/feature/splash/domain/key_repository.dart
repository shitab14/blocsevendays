import '../../../core/exceptions/app_exceptions.dart';
import 'package:dart_either/dart_either.dart';

import 'key_entity.dart';

abstract class KeyRepository {
  Future<Either<AppException, KeyEntity>> getKey();
}
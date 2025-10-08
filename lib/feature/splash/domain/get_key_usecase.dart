import 'package:dart_either/dart_either.dart';
import '../../../../core/exceptions/app_exceptions.dart';
import 'key_entity.dart';
import 'key_repository.dart';

class GetKeyUseCase {
  final KeyRepository _repository;

  GetKeyUseCase(this._repository);

  Future<Either<AppException, KeyEntity>> call() async {
    return await _repository.getKey();
  }
}
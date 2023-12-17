import 'package:dartz/dartz.dart';
import 'package:event_platform_app/core/error/failure.dart';
import 'package:event_platform_app/domain/repository/repository.dart';

class RegisterUsecase {
  final Repository _repository;

  RegisterUsecase(this._repository);

  Future<Either<Failure, String>> execute(String email, String password) async {
    return await _repository.registerWithEmailAndPassword(email, password);
  }
}

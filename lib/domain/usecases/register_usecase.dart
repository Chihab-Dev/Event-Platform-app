import 'package:dartz/dartz.dart';
import 'package:event_platform_app/core/error/failure.dart';
import 'package:event_platform_app/domain/repository/repository.dart';

import '../entities/user.dart';

class RegisterUsecase {
  final Repository _repository;

  RegisterUsecase(this._repository);

  Future<Either<Failure, String>> execute(User user, String password) async {
    return await _repository.register(user, password);
  }
}

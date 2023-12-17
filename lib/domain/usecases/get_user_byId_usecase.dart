import 'package:dartz/dartz.dart';
import 'package:event_platform_app/core/error/failure.dart';
import 'package:event_platform_app/domain/entities/member.dart';
import 'package:event_platform_app/domain/repository/repository.dart';

class GetUserByIdUsecase {
  final Repository _repository;

  GetUserByIdUsecase(this._repository);

  Future<Either<Failure, Member>> execute(String id) async {
    return await _repository.getUserById(id);
  }
}

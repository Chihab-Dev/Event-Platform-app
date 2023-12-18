import 'package:dartz/dartz.dart';
import 'package:event_platform_app/core/error/failure.dart';
import 'package:event_platform_app/domain/entities/member.dart';
import 'package:event_platform_app/domain/repository/repository.dart';

class AddNewUserToFiresbaseUsecase {
  final Repository _repository;

  AddNewUserToFiresbaseUsecase(this._repository);

  Future<Either<Failure, String>> execute(Member member) async {
    return await _repository.addNewUserToFiresbase(member);
  }
}

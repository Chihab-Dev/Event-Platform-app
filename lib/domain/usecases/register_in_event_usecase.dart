import 'package:dartz/dartz.dart';
import 'package:event_platform_app/core/error/failure.dart';
import 'package:event_platform_app/domain/repository/repository.dart';

class RegisterInEventUsecase {
  final Repository _repository;

  RegisterInEventUsecase(this._repository);

  Future<Either<Failure, void>> execute(String email, String eventId) async {
    return await _repository.registerInEvent(email, eventId);
  }
}

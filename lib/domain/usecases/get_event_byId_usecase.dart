import 'package:dartz/dartz.dart';
import 'package:event_platform_app/core/error/failure.dart';
import 'package:event_platform_app/domain/entities/event.dart';
import 'package:event_platform_app/domain/repository/repository.dart';

class GetEventByIdUsecase {
  final Repository _repository;

  GetEventByIdUsecase(this._repository);

  Future<Either<Failure, Event>> execute(String id) async {
    return await _repository.getEventById(id);
  }
}

import 'package:dartz/dartz.dart';
import 'package:event_platform_app/core/error/failure.dart';
import 'package:event_platform_app/domain/entities/event.dart';
import 'package:event_platform_app/domain/repository/repository.dart';

class GetAllEventsUsecase {
  final Repository _repository;

  GetAllEventsUsecase(this._repository);

  Future<Either<Failure, List<Event>>> execute() async {
    return await _repository.getAllEvents();
  }
}

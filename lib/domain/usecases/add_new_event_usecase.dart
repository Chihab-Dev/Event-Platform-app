import 'package:dartz/dartz.dart';
import 'package:event_platform_app/core/error/failure.dart';
import 'package:event_platform_app/domain/entities/event.dart';
import 'package:event_platform_app/domain/repository/repository.dart';

class AddNewEventUsecase {
  final Repository _repository;

  AddNewEventUsecase(this._repository);

  Future<Either<Failure, void>> execute(Event event) async {
    return await _repository.addNewEvent(event);
  }
}

import 'package:dartz/dartz.dart';
import 'package:event_platform_app/core/error/failure.dart';
import 'package:event_platform_app/domain/entities/event.dart';
import 'package:event_platform_app/domain/entities/user.dart';

abstract class Repository {
  Future<Either<Failure, String>> login(String email, String password);
  Future<Either<Failure, String>> register(User user, String password);
  Future<Either<Failure, User>> getUserById(String id);
  Future<Either<Failure, List<Event>>> getAllEvents();
  Future<Either<Failure, void>> registerInEvent(User user);
  Future<Either<Failure, void>> addNewEvent(Event event);
}

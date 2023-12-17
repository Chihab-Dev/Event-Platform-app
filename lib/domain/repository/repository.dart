import 'package:dartz/dartz.dart';
import 'package:event_platform_app/core/error/failure.dart';
import 'package:event_platform_app/domain/entities/event.dart';
import 'package:event_platform_app/domain/entities/member.dart';

abstract class Repository {
  Future<Either<Failure, String>> loginWithEmailAndPassword(String email, String password);
  Future<Either<Failure, String>> registerWithEmailAndPassword(String email, String password);
  Future<Either<Failure, String>> addNewUserToFiresbase(Member member);
  Future<Either<Failure, Member>> getUserById(String id);
  Future<Either<Failure, void>> addNewEvent(Event event);
  Future<Either<Failure, List<Event>>> getAllEvents();
  Future<Either<Failure, void>> registerInEvent(String email, String eventId);
}

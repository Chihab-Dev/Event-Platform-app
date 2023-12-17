import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:event_platform_app/core/error/failure.dart';
import 'package:event_platform_app/core/utils/constances.dart';
import 'package:event_platform_app/data/data_source/remote_data_source.dart';
import 'package:event_platform_app/data/network/network_checker.dart';
import 'package:event_platform_app/domain/entities/event.dart';
import 'package:event_platform_app/domain/entities/member.dart';
import 'package:event_platform_app/domain/repository/repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RepositoryImpl implements Repository {
  final NetworkInfo _networkInfo;
  final RemoteDataSource _remoteDataSource;

  RepositoryImpl(this._networkInfo, this._remoteDataSource);
  @override
  Future<Either<Failure, String>> registerWithEmailAndPassword(String email, String password) async {
    if (await _networkInfo.isConncted()) {
      try {
        String response = await _remoteDataSource.registerWithEmailAndPassword(email, password);
        return right(response);
      } on FirebaseAuthException catch (e) {
        return left(Failure(e.message.toString()));
      }
    } else {
      return left(Failure(ErrorsConstance.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, String>> addNewUserToFiresbase(Member member) async {
    if (await _networkInfo.isConncted()) {
      try {
        String response = await _remoteDataSource.addNewUserToFiresbase(member);

        return right(response);
      } on FirebaseAuthException catch (e) {
        return left(Failure(e.message.toString()));
      }
    } else {
      return left(Failure(ErrorsConstance.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, String>> loginWithEmailAndPassword(String email, String password) async {
    if (await _networkInfo.isConncted()) {
      try {
        String response = await _remoteDataSource.loginWithEmailAndPassword(email, password);
        return right(response);
      } on FirebaseAuthException catch (e) {
        return left(Failure(e.message.toString()));
      }
    } else {
      return left(Failure(ErrorsConstance.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, Member>> getUserById(String id) async {
    if (await _networkInfo.isConncted()) {
      try {
        Member user = await _remoteDataSource.getUserById(id);

        return right(user);
      } on FirebaseAuthException catch (e) {
        return left(Failure(e.message.toString()));
      }
    } else {
      return left(Failure(ErrorsConstance.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, void>> addNewEvent(Event event) async {
    if (await _networkInfo.isConncted()) {
      try {
        await _remoteDataSource.addNewEvent(event);
        return right(Void);
      } on FirebaseAuthException catch (e) {
        return left(Failure(e.message.toString()));
      }
    } else {
      return left(Failure(ErrorsConstance.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, List<Event>>> getAllEvents() async {
    if (await _networkInfo.isConncted()) {
      try {
        List<Event> eventsList = await _remoteDataSource.getAllEvents();

        return right(eventsList);
      } on FirebaseAuthException catch (e) {
        return left(Failure(e.message.toString()));
      }
    } else {
      return left(Failure(ErrorsConstance.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, void>> registerInEvent(String email, String eventId) async {
    if (await _networkInfo.isConncted()) {
      try {
        await _remoteDataSource.registerInEvent(email, eventId);

        return right(Void);
      } on FirebaseAuthException catch (e) {
        return left(Failure(e.message.toString()));
      }
    } else {
      return left(Failure(ErrorsConstance.noInternetConnection));
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_platform_app/data/data_source/remote_data_source.dart';
import 'package:event_platform_app/data/network/firebase_auth.dart';
import 'package:event_platform_app/data/network/firebase_firesotre.dart';
import 'package:event_platform_app/data/network/network_checker.dart';
import 'package:event_platform_app/data/repository/repository_impl.dart';
import 'package:event_platform_app/domain/repository/repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final getIt = GetIt.instance;

class ServicesLocator {
  void init() {
    InternetConnectionChecker internetConnectionChecker = InternetConnectionChecker();

    getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(internetConnectionChecker));

    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    getIt.registerLazySingleton<FirebaseAuthentication>(() => FirebaseAuthentication(firebaseAuth));

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    getIt.registerLazySingleton<FirebaseStore>(() => FirebaseStore(firebaseFirestore));

    getIt.registerLazySingleton<RemoteDataSource>(
        () => RemoteDataSourceImpl(getIt<FirebaseAuthentication>(), getIt<FirebaseStore>()));

    getIt.registerLazySingleton<Repository>(() => RepositoryImpl(getIt<NetworkInfo>(), getIt<RemoteDataSource>()));
  }
}

import 'package:event_platform_app/data/models/event_model.dart';
import 'package:event_platform_app/data/models/member_model.dart';
import 'package:event_platform_app/data/network/firebase_auth.dart';
import 'package:event_platform_app/data/network/firebase_firesotre.dart';
import 'package:event_platform_app/domain/entities/event.dart';
import 'package:event_platform_app/domain/entities/member.dart';

abstract class RemoteDataSource {
  Future<String> loginWithEmailAndPassword(String email, String password);
  Future<String> registerWithEmailAndPassword(String email, String password);
  Future<String> addNewUserToFiresbase(Member member);
  Future<MemberModel> getUserById(String id);
  Future<EventModel> getEventById(String id);
  Future<void> addNewEvent(Event event);
  Future<List<EventModel>> getAllEvents();
  Future<void> registerInEvent(String email, String eventId);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseAuthentication _firebaseAuthentication;
  final FirebaseStore _firebaseStore;

  RemoteDataSourceImpl(this._firebaseAuthentication, this._firebaseStore);
  @override
  Future<String> loginWithEmailAndPassword(String email, String password) async {
    return await _firebaseAuthentication.loginWithEmailAndPassword(email, password);
  }

  @override
  Future<String> registerWithEmailAndPassword(String email, String password) async {
    return await _firebaseAuthentication.registerWithEmailAndPassword(email, password);
  }

  @override
  Future<String> addNewUserToFiresbase(Member member) async {
    return await _firebaseStore.addNewUserToFiresbase(
      MemberModel(id: member.id, fullName: member.fullName, email: member.email),
    );
  }

  @override
  Future<MemberModel> getUserById(String id) async {
    return await _firebaseStore.getUserById(id);
  }

  @override
  Future<List<EventModel>> getAllEvents() async {
    return await _firebaseStore.getAllEvents();
  }

  @override
  Future<void> addNewEvent(Event event) async {
    return await _firebaseStore.addNewEvent(EventModel(
      id: event.id,
      name: event.name,
      desc: event.desc,
      image: event.image,
      category: event.category,
      dateBegin: event.dateBegin,
      dateEnd: event.dateEnd,
      registeredUsers: event.registeredUsers,
    ));
  }

  @override
  Future<void> registerInEvent(String email, String eventId) async {
    return await _firebaseStore.registerInEvent(
      email,
      eventId,
    );
  }

  @override
  Future<EventModel> getEventById(String id) async {
    return await _firebaseStore.getEventById(id);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_platform_app/core/utils/constances.dart';
import 'package:event_platform_app/data/models/event_model.dart';
import 'package:event_platform_app/data/models/member_model.dart';

class FirebaseStore {
  final FirebaseFirestore _firebaseFirestore;

  FirebaseStore(this._firebaseFirestore);

  Future<String> addNewUserToFiresbase(MemberModel user) async {
    try {
      await _firebaseFirestore.collection(FirebaseConstance.users).doc(user.id).set(user.toJson());
      return user.id;
    } on FirebaseException catch (e) {
      print("🛑 error addNewUserToFirestore");
      print(e.message);
      rethrow;
    }
  }

  Future<MemberModel> getUserById(String id) async {
    try {
      return await _firebaseFirestore.collection(FirebaseConstance.users).doc(id).get().then(
        (value) {
          return MemberModel.fromJson(value.data()!);
        },
      ).catchError((onError) {
        print("error getUserById");
        print(onError.toString());
        throw onError;
      });
    } on FirebaseException catch (e) {
      print("error getUserById");
      print(e);
      rethrow;
    }
  }

  Future<List<EventModel>> getAllEvents() async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore.collection(FirebaseConstance.events).get();

      List<EventModel> eventsList = [];

      for (var doc in querySnapshot.docs) {
        eventsList.add(EventModel.fromJson(doc.data() as Map<String, dynamic>));
      }

      return eventsList;
    } on FirebaseException catch (e) {
      print("Error getting all events: $e");
      rethrow;
    }
  }

  Future<void> addNewEvent(EventModel event) async {
    try {
      await _firebaseFirestore.collection(FirebaseConstance.events).add(event.toJson()).then(
        (value) {
          value.update(
            {'id': value.id},
          );
        },
      );
    } on FirebaseException catch (e) {
      print("Error addNewEvent: $e");
      rethrow;
    }
  }

  Future<void> registerInEvent(String email, String eventId) async {
    try {
      final eventDocument = await _firebaseFirestore.collection(FirebaseConstance.events).doc(eventId).get();
      List<dynamic> registeredUsers = eventDocument.data()?['registeredUsers'] ?? [];

      registeredUsers.add(email);

      await _firebaseFirestore.collection(FirebaseConstance.events).doc(eventId).update(
        {
          'registeredUsers': registeredUsers,
        },
      );
    } on FirebaseException catch (e) {
      print("Error registerInEvent: $e");
      rethrow;
    }
  }

  Future<EventModel> getEventById(String id) async {
    try {
      return await _firebaseFirestore.collection(FirebaseConstance.events).doc(id).get().then(
        (value) {
          return EventModel.fromJson(value.data()!);
        },
      ).catchError((onError) {
        print("error getEventById");
        print(onError.toString());
        throw onError;
      });
    } on FirebaseException catch (e) {
      print("error getEventById");
      print(e);
      rethrow;
    }
  }
}

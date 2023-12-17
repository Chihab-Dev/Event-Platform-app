import 'package:event_platform_app/domain/entities/event.dart';

class EventModel extends Event {
  EventModel({
    required super.id,
    required super.name,
    required super.desc,
    required super.image,
    required super.category,
    required super.dateBegin,
    required super.dateEnd,
    required super.registeredUsers,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    // var usersList = json["registeredUsers"] as List<dynamic>;

    // List<UserModel> users = usersList.map(
    //   (user) {
    //     return UserModel.fromJson(user as Map<String, dynamic>);
    //   },
    // ).toList();

    var usersList = json["registeredUsers"] as List<dynamic>;

    List<String> userIDs = List<String>.from(usersList);

    return EventModel(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      image: json['image'],
      category: json['category'],
      dateBegin: json['dateBegin'],
      dateEnd: json['dateEnd'],
      registeredUsers: userIDs,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'image': image,
      'category': category,
      'dateBegin': dateBegin,
      'dateEnd': dateEnd,
      'registeredUsers': registeredUsers,
    };
  }
}

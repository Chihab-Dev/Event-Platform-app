// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:event_platform_app/domain/entities/user.dart';

class Event {
  String name;
  String desc;
  String image;
  String category;
  String dateBegin;
  String dateEnd;
  List<User> registeredUsers;

  Event(
    this.name,
    this.desc,
    this.image,
    this.category,
    this.dateBegin,
    this.dateEnd,
    this.registeredUsers,
  );
}

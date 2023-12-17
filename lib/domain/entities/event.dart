// ignore_for_file: public_member_api_docs, sort_constructors_first

class Event {
  String id;
  String name;
  String desc;
  String image;
  String category;
  String dateBegin;
  String dateEnd;
  List<String> registeredUsers;

  Event({
    required this.id,
    required this.name,
    required this.desc,
    required this.image,
    required this.category,
    required this.dateBegin,
    required this.dateEnd,
    required this.registeredUsers,
  });
}

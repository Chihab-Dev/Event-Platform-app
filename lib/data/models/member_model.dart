import 'package:event_platform_app/domain/entities/member.dart';

class MemberModel extends Member {
  MemberModel({
    required super.id,
    required super.fullName,
    required super.email,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
    };
  }
}

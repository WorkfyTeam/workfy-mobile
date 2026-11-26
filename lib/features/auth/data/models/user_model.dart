import 'package:workbridge/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({required super.id, required super.firstName, required super.lastName, required super.email, required super.role, super.avatarUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'] ?? '', firstName: json['firstname'] ?? '', lastName: json['lastname'] ?? '', email: json['email'] ?? '', role: json['role'] ?? 'job_seeker', avatarUrl: json['avatarUrl']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'firstname': firstName, 'lastname': lastName, 'email': email, 'role': role, 'avatarUrl': avatarUrl};
  }
}

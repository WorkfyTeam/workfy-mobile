import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String role; // 'job_seeker', 'business_owner'
  final String? avatarUrl;

  const UserEntity({required this.id, required this.firstName, required this.lastName, required this.email, required this.role, this.avatarUrl});

  @override
  List<Object?> get props => [id, firstName, lastName, email, role, avatarUrl];
}

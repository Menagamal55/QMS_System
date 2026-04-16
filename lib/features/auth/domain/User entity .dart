// lib/features/auth/domain/entities/user_entity.dart

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name;
  final String email;
  final String? token;
final String role;
  const UserEntity({
    required this.name,
    required this.email,
    this.token,
    required this.role,
  });

  @override
  List<Object?> get props => [name, email, token, role];
}
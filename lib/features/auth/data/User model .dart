// lib/features/auth/data/models/user_model.dart


import 'package:sw2project/features/auth/domain/User%20entity%20.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.name,
    required super.email,
    super.token, required super.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? json['Name'] ?? '',
      email: json['email'] ?? json['Email'] ?? '',
      token: json['token'] ?? json['Token'] ?? json['accessToken'], role: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'token': token,
    };
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      name: entity.name,
      email: entity.email,
      token: entity.token, role: '',
    );
  }
}
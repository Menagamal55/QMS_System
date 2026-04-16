// lib/features/auth/presentation/bloc/auth_state.dart


import 'package:equatable/equatable.dart';
import 'package:sw2project/features/auth/domain/User%20entity%20.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  final UserEntity user;
  final String message;

  const AuthSuccess({required this.user, required this.message});

  @override
  List<Object?> get props => [user, message];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

import 'package:dartz/dartz.dart';
import 'package:sw2project/core/base_usecase/fauliers.dart';
import 'package:sw2project/features/auth/domain/User%20entity%20.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String email,
    required String password,
  });
}
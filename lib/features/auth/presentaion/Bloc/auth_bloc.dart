// lib/features/auth/presentation/bloc/auth_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sw2project/core/network/cach_helper.dart';
import 'package:sw2project/features/auth/domain/usecases/Login%20usecase%20.dart';
import 'package:sw2project/features/auth/domain/usecases/Register%20usecase%20.dart';
import 'package:sw2project/features/auth/presentaion/Bloc/auth_event.dart';
import 'package:sw2project/features/auth/presentaion/Bloc/auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
  }) : super(const AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<ResetAuthStateEvent>(_onReset);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    final result = await loginUseCase(
      LoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    // التعديل هنا: خلينا الدوال جوه الـ fold تشتغل بـ async
    await result.fold(
      (failure) async => emit(AuthFailure(message: failure.message)),
      (user) async {
        // 🚀 حفظ التوكن والرول في الجهاز 🚀
        // (تأكدي إن كلمة token و role مطابقة للي مكتوبين جوه الـ User Entity بتاعك)
        await CacheHelper.saveData(key: 'token', value: user.token);
        await CacheHelper.saveData(key: 'role', value: user.role);

        emit(AuthSuccess(user: user, message: 'Login successful!'));
      },
    );
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    final result = await registerUseCase(
      RegisterParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    await result.fold(
      (failure) async => emit(AuthFailure(message: failure.message)),
      (user) async {
        // لو الـ API بتاع نسرين بيرجع توكن ورول مع الـ Register كمان، احفظيهم هنا برضه
        await CacheHelper.saveData(key: 'token', value: user.token);
        await CacheHelper.saveData(key: 'role', value: user.role);

        emit(AuthSuccess(user: user, message: 'Registration successful!'));
      },
    );
  }

  void _onReset(ResetAuthStateEvent event, Emitter<AuthState> emit) {
    emit(const AuthInitial());
  }
}
// lib/injection_container.dart

import 'package:get_it/get_it.dart';
import 'package:sw2project/features/auth/data/repositories/Auth%20remote%20datasource%20.dart';
import 'package:sw2project/features/auth/domain/usecases/Login%20usecase%20.dart';
import 'package:sw2project/features/auth/domain/usecases/Register%20usecase%20.dart';
import 'package:sw2project/features/auth/presentaion/Bloc/auth_bloc.dart';
import 'core/network/dio_client.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<DioClient>(() => DioClient());

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dioClient: sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));

  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
    ),
  );
}

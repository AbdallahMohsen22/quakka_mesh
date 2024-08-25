import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/network/api_service/api_service.dart';
import 'core/network/dio_factory.dart';
import 'features/auth/cubit/auth_cubit.dart';

final getIt = GetIt.instance;

void initGetIt() {
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
  //login
  // getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
  // getIt.registerLazySingleton<ForgetPasswordCubit>(() => ForgetPasswordCubit(getIt()));
  // getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  //
  //register
  // getIt.registerLazySingleton<RegisterRepo>(() => RegisterRepo(getIt()));
  getIt.registerLazySingleton<RegisterCubit>(() => RegisterCubit());
  // ads packages

}

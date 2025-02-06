import 'package:get_it/get_it.dart';
import 'package:mobile_lingkunganku/modules/profile/cubit/profile_cubit.dart';
import 'package:mobile_lingkunganku/repositories/profile_repository/profile_repository.dart';

import '../modules/app/bloc/app_bloc.dart';
import '../modules/onboarding/cubit/onboarding_cubit.dart';
import '../repositories/auth_repository/auth_repository.dart';
import '../repositories/home_repository/home_repository.dart';
import 'http_client.dart';

final getIt = GetIt.instance;

class MyInjection {
  static setup() {
    getIt.registerLazySingleton<AppBloc>(() => AppBloc());
    getIt.registerLazySingleton<BaseNetworkClient>(
      () => BaseNetworkClient(),
    );

    getIt.registerLazySingleton<OnboardingCubit>(() => OnboardingCubit());
    getIt.registerLazySingleton<ProfileCubit>(() => ProfileCubit());

    getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
    getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepository());
    getIt.registerLazySingleton<HomeRepository>(() => HomeRepository());
  }
}

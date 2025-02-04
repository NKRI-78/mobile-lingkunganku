import 'package:get_it/get_it.dart';
import 'package:mobile_lingkunganku/modules/onboarding/cubit/onboarding_cubit.dart';

import '../modules/app/bloc/app_bloc.dart';
import '../repositories/auth_repository/auth_repository.dart';
import 'http_client.dart';

final getIt = GetIt.instance;

class MyInjection {
  static setup() {
    getIt.registerLazySingleton<AppBloc>(() => AppBloc());
    getIt.registerLazySingleton<BaseNetworkClient>(
      () => BaseNetworkClient(),
    );

    getIt.registerLazySingleton<OnboardingCubit>(() => OnboardingCubit());

    getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
  }
}

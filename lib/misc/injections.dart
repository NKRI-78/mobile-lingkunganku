import 'package:get_it/get_it.dart';
import '../modules/profile/cubit/profile_cubit.dart';
import '../repositories/profile_repository/profile_repository.dart';

import '../modules/app/bloc/app_bloc.dart';
import '../modules/detail_news/cubit/detail_news_cubit.dart';
import '../modules/onboarding/cubit/onboarding_cubit.dart';
import '../repositories/auth_repository/auth_repository.dart';
import '../repositories/home_repository/home_repository.dart';
import '../repositories/news_repository/news_repository.dart';
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
    getIt.registerLazySingleton<DetailNewsCubit>(() => DetailNewsCubit());

    getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
    getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepository());
    getIt.registerLazySingleton<HomeRepository>(() => HomeRepository());
    getIt.registerLazySingleton<NewsRepository>(() => NewsRepository());
  }
}

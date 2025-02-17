import 'package:get_it/get_it.dart';
import 'package:mobile_lingkunganku/modules/forum/cubit/forum_cubit.dart';
import 'package:mobile_lingkunganku/modules/management/cubit/management_cubit.dart';
import 'package:mobile_lingkunganku/modules/management_detail/cubit/management_detail_cubit.dart';
import 'package:mobile_lingkunganku/repositories/management_repository/management_repository.dart';
import '../modules/home/bloc/home_bloc.dart';
import '../modules/profile/cubit/profile_cubit.dart';
import '../modules/profile_update/cubit/profile_update_cubit.dart';
import '../repositories/forum_repository/forum_repository.dart';
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
    getIt.registerLazySingleton<HomeBloc>(
      () => HomeBloc(getIt<HomeRepository>(), getIt<ProfileCubit>()),
    );

    getIt.registerLazySingleton<BaseNetworkClient>(
      () => BaseNetworkClient(),
    );

    getIt.registerLazySingleton<OnboardingCubit>(() => OnboardingCubit());
    getIt.registerLazySingleton<ProfileCubit>(() => ProfileCubit());
    getIt.registerLazySingleton<ProfileUpdateCubit>(() => ProfileUpdateCubit());
    getIt.registerLazySingleton<DetailNewsCubit>(() => DetailNewsCubit());
    getIt.registerLazySingleton<ManagementCubit>(
        () => ManagementCubit(getIt<ManagementRepository>()));
    getIt.registerLazySingleton<ForumCubit>(() => ForumCubit());
    getIt.registerLazySingleton<ManagementDetailCubit>(
      () => ManagementDetailCubit(getIt<ManagementRepository>()),
    );

    getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
    getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepository());
    getIt.registerLazySingleton<HomeRepository>(() => HomeRepository());
    getIt.registerLazySingleton<NewsRepository>(() => NewsRepository());
    getIt.registerLazySingleton<ManagementRepository>(
        () => ManagementRepository());
    getIt.registerLazySingleton<ForumRepository>(() => ForumRepository());
  }
}

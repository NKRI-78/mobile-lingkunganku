import 'package:get_it/get_it.dart';

import '../modules/app/bloc/app_bloc.dart';

final getIt = GetIt.instance;

class MyInjection {
  static setup() {
    getIt.registerLazySingleton<AppBloc>(() => AppBloc());
  }
}

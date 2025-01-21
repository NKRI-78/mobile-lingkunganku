import 'package:get_it/get_it.dart';
import 'package:mobile_lingkunganku/modules/app/bloc/app_bloc.dart';

final getIt = GetIt.instance;

class MyInjection {
  static setup() {
    getIt.registerLazySingleton<AppBloc>(() => AppBloc());
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/location.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState(selectedIndex: 0)) {
    on<HomeInit>((event, emit) async {
      await determinePosition();
    });

    on<HomeNavigate>((event, emit) {
      emit(HomeState(selectedIndex: event.index));
    });
  }
}

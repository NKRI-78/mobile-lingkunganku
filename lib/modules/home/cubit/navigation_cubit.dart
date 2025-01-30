import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../misc/location.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);

  void init() async {
    await determinePosition();
    print('masuk :');
  }

  void navigateTo(int index) {
    emit(index); // Update state dengan index baru
  }
}

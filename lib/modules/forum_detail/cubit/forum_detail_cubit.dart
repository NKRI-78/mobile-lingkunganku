import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/repositories/forum_repository/forum_repository.dart';
import 'package:mobile_lingkunganku/repositories/forum_repository/models/forum_detail_model.dart';

part 'forum_detail_state.dart';

class ForumDetailCubit extends Cubit<ForumDetailState> {
  ForumDetailCubit() : super(const ForumDetailState());

  ForumRepository repo = ForumRepository();

  void copyState({required ForumDetailState newState}) {
    emit(newState);
  }
}

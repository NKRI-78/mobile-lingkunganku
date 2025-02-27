import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:mobile_lingkunganku/misc/snackbar.dart';
import 'package:mobile_lingkunganku/modules/forum/cubit/forum_cubit.dart';
import 'package:mobile_lingkunganku/repositories/forum_repository/forum_repository.dart';
import 'package:mobile_lingkunganku/repositories/forum_repository/models/forum_detail_model.dart';
import 'package:mobile_lingkunganku/router/builder.dart';

import '../../../misc/injections.dart';

part 'forum_detail_state.dart';

class ForumDetailCubit extends Cubit<ForumDetailState> {
  ForumDetailCubit() : super(const ForumDetailState());

  ForumRepository repo = ForumRepository();

  void copyState({required ForumDetailState newState}) {
    emit(newState);
  }

  Future<void> fetchForumDetail(String idForum) async {
    try {
      emit(state.copyWith(loading: true));
      var detailForum = await repo.getDetailForum(idForum);

      emit(state.copyWith(detailForum: detailForum, loading: false));
    } on SocketException {
      throw "Terjadi kesalahan jaringan";
    } catch (e) {
      rethrow;
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> deleteForum(
      {required String idForum, required BuildContext context}) async {
    try {
      await repo.deleteForum(idForum.toString());
      Future.delayed(Duration.zero, () {
        Navigator.of(context, rootNavigator: true).pop();
        ForumRoute().go(context);
        getIt<ForumCubit>().fetchForum();
        ShowSnackbar.snackbar(context, "Berhasil menghapus postingan", "",
            AppColors.secondaryColor);
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createComment(
      BuildContext context, String idForum, GlobalKey gk) async {
    try {
      emit(state.copyWith(loadingComment: true));
      int? idNewComment;
      if (state.inputComment.trim() == "") {
        return;
      } else {
        idNewComment = await repo.createComment(
          inputComment: state.inputComment,
          forumId: idForum,
          commentId: state.commentId,
        );
      }

      final detailForum = await repo.getDetailForum(idForum);

      emit(state.copyWith(
          detailForum: detailForum,
          idForum: idForum,
          lastIdComment: idNewComment));

      await Future.delayed(const Duration(milliseconds: 100));
      Scrollable.ensureVisible(
          alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
          GlobalObjectKey(idNewComment!).currentContext!,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease);

      emit(state.copyWith(inputComment: "", commentId: 0));
      Future.delayed(const Duration(seconds: 2), () {
        emit(state.copyWith(lastIdComment: 0));
      });
    } catch (e) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.secondaryColor,
          content: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    } finally {
      emit(state.copyWith(loadingComment: false));
    }
  }
}

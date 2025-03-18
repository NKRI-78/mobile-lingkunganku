import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/repositories/forum_repository/models/forums_model.dart';
import '../../../repositories/profile_repository/models/profile_model.dart';
import '../../../misc/colors.dart';
import '../../../misc/snackbar.dart';
import '../../../repositories/profile_repository/profile_repository.dart';
import '../../forum/cubit/forum_cubit.dart';
import '../../../repositories/forum_repository/forum_repository.dart';
import '../../../repositories/forum_repository/models/forum_detail_model.dart';
import '../../../router/builder.dart';

import '../../../misc/injections.dart';

part 'forum_detail_state.dart';

class ForumDetailCubit extends Cubit<ForumDetailState> {
  ForumDetailCubit() : super(const ForumDetailState());

  ForumRepository repo = ForumRepository();
  ProfileRepository repoProfile = getIt<ProfileRepository>();

  void init(String idForum) async {
    emit(state.copyWith(loading: true));
    await Future.wait([
      fetchForumDetail(idForum),
      fetchProfile(),
    ]);
    emit(state.copyWith(loading: false));
  }

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

  Future<void> fetchProfile() async {
    try {
      emit(state.copyWith(loading: true));
      var profile = await repoProfile.getProfile();

      emit(state.copyWith(loading: false, profile: profile));
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

  Future<void> setLikeUnlike(
      {required String commentId, required String idForum}) async {
    try {
      await repo.setLikeUnlike(commentId);
      final comment = await repo.getDetailForum(idForum);
      emit(ForumDetailState(
          idForum: idForum, detailForum: comment, loading: false));
    } catch (e) {
      ///
    }
  }

  Future<void> setLikeUnlikeForum({required String idForum}) async {
    try {
      // emit(state.copyWith(loading: true));
      await repo.setLikeUnlikeForum(idForum);
      final comment = await repo.getDetailForum(idForum);
      emit(state.copyWith(idForum: idForum, detailForum: comment));
    } catch (e) {
      rethrow;
    }
  }
}

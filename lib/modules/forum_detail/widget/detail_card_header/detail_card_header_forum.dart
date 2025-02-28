import 'package:flutter/material.dart';
import '../../../../repositories/forum_repository/models/forum_detail_model.dart';

import '../../../../misc/colors.dart';
import '../../../../misc/injections.dart';
import '../../../../widgets/image/image_avatar.dart';
import '../../../app/bloc/app_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

class DetailCardHeaderForum extends StatelessWidget {
  const DetailCardHeaderForum(
      {super.key, this.forum, required this.onSelected});

  final ForumDetailModel? forum;
  final Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    final userId = getIt<AppBloc>().state.user?.id;
    print('INI USER : ${userId}');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 8,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ImageAvatar(
                    image: forum?.user?.profile?.avatarLink ?? "",
                    radius: 20,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        forum?.user?.profile?.fullname ?? "",
                        maxLines: 3,
                        style: const TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        timeago.format(
                          forum?.createdAt != null
                              ? DateTime.tryParse(forum!.createdAt!) ??
                                  DateTime.now()
                              : DateTime.now(),
                          locale: 'id',
                        ),
                        style: const TextStyle(
                          color: AppColors.greyColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                forum?.userId == userId
                    ? PopupMenuButton(
                        color: AppColors.whiteColor,
                        iconColor: Colors.black,
                        iconSize: 30,
                        itemBuilder: (BuildContext buildContext) {
                          return [
                            const PopupMenuItem(
                                value: "/delete",
                                child: Text("Hapus",
                                    style: TextStyle(
                                      color: AppColors.greyColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ))),
                          ];
                        },
                        onSelected: onSelected,
                      )
                    : PopupMenuButton(
                        color: AppColors.whiteColor,
                        iconColor: Colors.black,
                        iconSize: 30,
                        initialValue: "Laporkan",
                        itemBuilder: (BuildContext buildContext) {
                          return [
                            const PopupMenuItem(
                                value: "/spam",
                                child: Text("Konten Spam",
                                    style: TextStyle(
                                      color: AppColors.greyColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ))),
                            const PopupMenuItem(
                                value: "/rasis",
                                child: Text("Konten Rasis",
                                    style: TextStyle(
                                      color: AppColors.greyColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ))),
                            const PopupMenuItem(
                                value: "/rasis",
                                child:
                                    Text("Ketelanjangan atau aktivitas seksual",
                                        style: TextStyle(
                                          color: AppColors.greyColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ))),
                            const PopupMenuItem(
                              value: "/rasis",
                              child: Text(
                                "Informasi Palsu",
                                style: TextStyle(
                                  color: AppColors.greyColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ];
                        },
                        onSelected: onSelected,
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

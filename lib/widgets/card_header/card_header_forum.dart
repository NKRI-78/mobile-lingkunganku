import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../misc/colors.dart';
import '../../misc/injections.dart';
import '../../modules/app/bloc/app_bloc.dart';
import '../../repositories/forum_repository/models/forums_model.dart';
import '../image/image_avatar.dart';

class CardHeaderForum extends StatelessWidget {
  const CardHeaderForum(
      {super.key, required this.forums, required this.onSelected});

  final ForumsModel forums;
  final Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    final userId = getIt<AppBloc>().state.user?.id;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 8,
            child: Row(
              children: [
                Expanded(
                  flex: 0,
                  child: ImageAvatar(
                    image: forums.user?.profile.avatarLink ?? "",
                    radius: 25,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        forums.user?.profile.fullname ?? "",
                        maxLines: 3,
                        style: const TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Text('Sebagai ${forums.user?.profile. ?? ""}',
                      //     style: const TextStyle(
                      //       color: AppColors.greyColor,
                      //       fontSize: 10,
                      //     )),
                      Text(
                        timeago.format(
                          forums.createdAt != null
                              ? DateTime.tryParse(forums.createdAt!) ??
                                  DateTime.now()
                              : DateTime.now(),
                          locale: 'id',
                        ),
                        style: const TextStyle(
                          color: AppColors.greyColor,
                          fontSize: 10,
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
                  forums.userId == userId
                      ? PopupMenuButton(
                          color: AppColors.whiteColor,
                          iconColor: Colors.black,
                          iconSize: 30,
                          itemBuilder: (BuildContext buildContext) {
                            return [
                              const PopupMenuItem(
                                value: "/delete",
                                child: Text(
                                  "Hapus",
                                  style: TextStyle(
                                    color: AppColors.greyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
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
                                child: Text(
                                  "Konten Spam",
                                  style: TextStyle(
                                    color: AppColors.greyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const PopupMenuItem(
                                value: "/rasis",
                                child: Text(
                                  "Konten Rasis",
                                  style: TextStyle(
                                    color: AppColors.greyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const PopupMenuItem(
                                value: "/rasis",
                                child: Text(
                                  "Ketelanjangan atau aktivitas seksual",
                                  style: TextStyle(
                                    color: AppColors.greyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const PopupMenuItem(
                                value: "/rasis",
                                child: Text(
                                  "Informasi Palsu",
                                  style: TextStyle(
                                    color: AppColors.greyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ];
                          },
                          onSelected: onSelected,
                        )
                ],
              )),
        ],
      ),
    );
  }
}

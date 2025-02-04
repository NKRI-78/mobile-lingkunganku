import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:mobile_lingkunganku/misc/text_style.dart';
import 'package:mobile_lingkunganku/router/builder.dart';

void showRegisterDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: const EdgeInsets.all(12),
        content: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/icons/chat_bubble.png',
                  width: 150,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 10),
                Text(
                  "Apakah kamu belum memiliki akun lingkungan ku?",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.textDialog,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 130,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          LoginRoute().go(context);
                          Navigator.of(context).pop();
                        },
                        child: const Text("Sudah",
                            style: TextStyle(color: AppColors.whiteColor)),
                      ),
                    ),
                    SizedBox(
                      width: 130,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          RegisterRoute().go(context);
                          Navigator.of(context).pop();
                        },
                        child: const Text("Belum",
                            style: TextStyle(color: AppColors.whiteColor)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: -10,
              right: -10,
              child: IconButton(
                icon: const Icon(Icons.close, color: AppColors.textColor),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

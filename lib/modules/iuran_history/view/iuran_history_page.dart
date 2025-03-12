import 'package:flutter/material.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';

class IuranHistoryPage extends StatelessWidget {
  const IuranHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IuranHistoryView();
  }
}

class IuranHistoryView extends StatelessWidget {
  const IuranHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.3),
        title: Text('Riwayat Iuran', style: AppTextStyles.textStyle1),
        centerTitle: true,
        toolbarHeight: 100,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.buttonColor2,
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Add your refresh logic here
        },
        child: Padding(
            padding: EdgeInsets.symmetric(
          horizontal: 20,
        )),
      ),
    );
  }
}

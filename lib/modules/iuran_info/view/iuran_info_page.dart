import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:mobile_lingkunganku/misc/text_style.dart';

class IuranInfoPage extends StatelessWidget {
  const IuranInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IuranInfoView();
  }
}

class IuranInfoView extends StatelessWidget {
  const IuranInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.3),
        title: Text('Information Iuran', style: AppTextStyles.textStyle1),
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
    );
  }
}

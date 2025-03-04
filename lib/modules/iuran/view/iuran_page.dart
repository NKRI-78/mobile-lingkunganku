import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:mobile_lingkunganku/misc/text_style.dart';
import 'package:mobile_lingkunganku/modules/iuran/widget/custom_list_section.dart';
import 'package:mobile_lingkunganku/widgets/button/custom_button.dart';

class IuranPage extends StatelessWidget {
  const IuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IuranView();
  }
}

class IuranView extends StatelessWidget {
  const IuranView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.3),
        title: Text(
          'Iuran',
          style: AppTextStyles.textStyle1,
        ),
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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.event_note_sharp,
              color: AppColors.buttonColor2,
              size: 26,
            ),
            onPressed: () {
              //
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              CustomListSection(),
              CustomListSection(),
              CustomListSection(),
              CustomListSection(),
              CustomListSection(),
              CustomListSection(),
              CustomListSection(),
              CustomListSection(),
              CustomListSection(),
              CustomListSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: CustomButton(
          text: "Bayar Tagihan",
          onPressed: () {
            //
          },
        ),
      ),
    );
  }
}

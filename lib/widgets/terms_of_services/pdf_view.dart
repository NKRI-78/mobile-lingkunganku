import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../misc/colors.dart';
import '../../misc/text_style.dart';

class TermsPdfPage extends StatelessWidget {
  const TermsPdfPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Syarat & Ketentuan",
          style: AppTextStyles.textStyle1,
        ),
        centerTitle: true,
        toolbarHeight: 80,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.buttonColor2,
            size: 24,
          ),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: SfPdfViewer.network(
          'https://docs.google.com/document/d/1SMPJdG4lHoOh_QRvvFcCaGCCzW5fGoadCqMAEU_wg5Y/export?format=pdf',
        ),
      ),
    );
  }
}

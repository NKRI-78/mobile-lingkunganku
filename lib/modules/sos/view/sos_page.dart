import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../misc/colors.dart';
import '../../../misc/text_style.dart';
import '../../../router/builder.dart';
import '../../../widgets/background/custom_background.dart';
import '../../../widgets/button/custom_button.dart';
import '../widget/custom_card_section.dart';

class SosPage extends StatelessWidget {
  const SosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'SOS',
          style: AppTextStyles.textStyle1,
        ),
        toolbarHeight: 100,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.buttonColor2,
            size: 32,
          ),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          CustomBackground(),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 100, bottom: 30),
                child: Text(
                  'Pilih Darurat apa yang kamu alami, maka\nuser dalam satu Lingkungan mu akan\nmendapatkan notifikasi',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textColor2,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Intel',
                  ),
                ),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 20,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  children: [
                    customCardSection(
                      icon: 'assets/images/kecelakaan.png',
                      label: 'Kecelakaan',
                      onTap: () {
                        RegisterRoute().go(context);
                        // Aksi untuk opsi Kecelakaan
                        print('Kecelakaan dipilih');
                      },
                    ),
                    customCardSection(
                      icon: 'assets/images/pencurian.png',
                      label: 'Pencurian',
                      onTap: () {
                        RegisterRoute().go(context);
                        // Aksi untuk opsi Pencurian
                        print('Pencurian dipilih');
                      },
                    ),
                    customCardSection(
                      icon: 'assets/images/kebakaran.png',
                      label: 'Kebakaran',
                      onTap: () {
                        RegisterRoute().go(context);
                        // Aksi untuk opsi Kebakaran
                        print('Kebakaran dipilih');
                      },
                    ),
                    customCardSection(
                      icon: 'assets/images/bencana_alam.png',
                      label: 'Bencana Alam',
                      onTap: () {
                        RegisterRoute().go(context);
                        // Aksi untuk opsi Bencana Alam
                        print('Bencana Alam dipilih');
                      },
                    ),
                    customCardSection(
                      icon: 'assets/images/donor_darah.png',
                      label: 'Donor Darah',
                      onTap: () {
                        RegisterRoute().go(context);
                        // Aksi untuk opsi Donor Darah
                        print('Donor Darah dipilih');
                      },
                    ),
                    customCardSection(
                      icon: 'assets/images/kerusuhan.png',
                      label: 'Kerusuhan',
                      onTap: () {
                        RegisterRoute().go(context);
                        // Aksi untuk opsi Kerusuhan
                        print('Kerusuhan dipilih');
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30, left: 30, right: 30),
                child: SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    icon: Icons.phone_in_talk,
                    text: 'Hubungi Keamanan',
                    onPressed: () {
                      // Navigate To Register
                      RegisterRoute().go(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

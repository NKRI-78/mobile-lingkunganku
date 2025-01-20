import 'package:flutter/material.dart';
import 'package:mobile_lingkunganku/core/utils/colors.dart';

final List<Map<String, dynamic>> onboardingContent = [
  {
    'title': [
      TextSpan(
        text: 'Pembayaran ',
        style: TextStyle(
            color: AppColors.textColor1,
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter'),
      ),
      TextSpan(
        text: 'Iuran',
        style: TextStyle(
            color: AppColors.textColor2,
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter'),
      ),
    ],
    'description':
        'Dengan fitur ini, warga dapat dengan mudah membayar berbagai jenis iuran langsung dari aplikasi, tanpa perlu repot datang ke kantor RT/RW atau tempat pembayaran lainnya.',
    'image': 'assets/images/onboarding_pembayaran.png',
  },
  {
    'title': [
      TextSpan(
        text: 'Fitur ',
        style: TextStyle(
            color: AppColors.textColor1,
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter'),
      ),
      TextSpan(
        text: 'Forum',
        style: TextStyle(
            color: AppColors.textColor2,
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter'),
      ),
    ],
    'description':
        'Fitur Forum Warga memungkinkan seluruh warga di lingkungan Anda untuk berkomunikasi, berdiskusi, dan berbagi informasi secara langsung melalui aplikasi.',
    'image': 'assets/images/onboarding_forum.png',
  },
  {
    'title': [
      TextSpan(
        text: 'Fitur ',
        style: TextStyle(
            color: AppColors.textColor1,
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter'),
      ),
      TextSpan(
        text: 'Panic Button',
        style: TextStyle(
            color: AppColors.textColor2,
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter'),
      ),
    ],
    'description':
        'Fitur Panic Button dirancang untuk memberikan keamanan ekstra bagi warga dalam situasi darurat. Dengan sekali tekan, warga dapat langsung mengirimkan sinyal bantuan ke pihak terkait seperti pengurus RT/RW, petugas keamanan, atau bahkan keluarga terdekat.',
    'image': 'assets/images/onboarding_panic_button.png',
  },
];

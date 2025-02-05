import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/injections.dart';
import '../../../misc/text_style.dart';
import '../../../router/builder.dart';
import '../../../widgets/background/custom_background.dart';
import '../../../widgets/button/custom_button.dart';
import '../../../widgets/header/custom_header_container.dart';
import '../../app/bloc/app_bloc.dart';
import '../bloc/home_bloc.dart';
import '../widget/bottom_nav_bar_section.dart';
import '../widget/drawer_section.dart';
import '../widget/show_dialog_register.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc()..add(HomeInit()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'assets/images/contoh.png',
      'assets/images/contoh.png',
      'assets/images/contoh.png',
    ];
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, appState) {
        final app = getIt<AppBloc>().state.isAlreadyLogin;
        return BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Scaffold(
              body: Stack(
                children: [
                  // CustomBackground sebagai gambar latar belakang
                  const CustomBackground(),
                  // CustomScrollView untuk konten yang dapat di-scroll
                  CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            const SizedBox(height: 300),
                            CarouselSlider(
                              options: CarouselOptions(
                                autoPlay: true,
                                enlargeCenterPage: true,
                              ),
                              items: imgList.map((item) {
                                return ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0)),
                                  child: Image.asset(
                                    item,
                                    fit: BoxFit.contain,
                                  ),
                                );
                              }).toList(),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("News", style: AppTextStyles.textStyle1),
                                  Text("See all",
                                      style: AppTextStyles.textStyle2),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            ...List.generate(
                              5,
                              (index) => Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: SizedBox(
                                  height: 120,
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(18),
                                            bottomLeft: Radius.circular(18)),
                                        child: Image.asset(
                                          'assets/images/contoh_card.png',
                                          fit: BoxFit.fill,
                                          width: 150,
                                          height: 150,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              'Sample News Title',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              'Short description goes here...',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // CustomHeaderContainer tetap statis di atas
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Builder(
                      builder: (context) {
                        return CustomHeaderContainer(
                          onMenuPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          onNotificationPressed: () {
                            // Handle notification button press
                          },
                          children: [
                            app
                                ? Text(
                                    'Selamat datang di Aplikasi Lingkunganku\nyang memudahkan Anda untuk terhubung dengan\nwarga sekitar dan menjaga lingkungan tetap harmonis.',
                                    style: AppTextStyles.textWelcome,
                                    textAlign: TextAlign.center,
                                  )
                                : CustomButton(
                                    text: 'Yuk registrasi baru !',
                                    onPressed: () {
                                      showRegisterDialog(context);
                                    },
                                  ),
                          ],
                        );
                      },
                    ),
                  ),

                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: BottomNavBarSection(
                      currentIndex: state.selectedIndex,
                      onTap: (index) {
                        switch (index) {
                          case 0:
                            break;
                          case 1:
                            break;
                          case 2:
                            break;
                          case 3:
                            break;
                          case 4:
                            SosRoute().go(context);
                            break;
                        }
                        context.read<HomeBloc>().add(HomeNavigate(index));
                      },
                    ),
                  ),
                ],
              ),
              drawer: const DrawerSection(),
            );
          },
        );
      },
    );
  }
}

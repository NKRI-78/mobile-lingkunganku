import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/misc/colors.dart';
import 'package:mobile_lingkunganku/modules/profile/cubit/profile_cubit.dart';
import 'package:mobile_lingkunganku/repositories/home_repository/home_repository.dart';

import '../../../misc/injections.dart';
import '../../../misc/text_style.dart';
import '../../../router/builder.dart';
import '../../../widgets/background/custom_background.dart';
import '../../../widgets/button/custom_button.dart';
import '../../../widgets/header/custom_header_container.dart';
import '../../app/bloc/app_bloc.dart';
import '../../news_detail/view/detail_news_page.dart';
import '../bloc/home_bloc.dart';
import '../widget/bottom_nav_bar_section.dart';
import '../widget/drawer_section.dart';
import '../widget/show_dialog_register.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => HomeBloc(getIt<HomeRepository>(), getIt<ProfileCubit>())
        ..add(HomeInit()),
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
                  const CustomBackground(),
                  CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 300),
                            CarouselSlider(
                              options: CarouselOptions(
                                autoPlay: true,
                                enlargeCenterPage: true,
                                aspectRatio: 16 / 9,
                                viewportFraction: 0.9,
                              ),
                              items: imgList.map((item) {
                                return ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0),
                                  ),
                                  child: Image.asset(
                                    item,
                                    fit: BoxFit.contain,
                                  ),
                                );
                              }).toList(),
                            ),

                            // Title Section
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "News",
                                    style: AppTextStyles.textStyle1,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Arahkan ke halaman semua berita
                                    },
                                    child: Text(
                                      "See all",
                                      style: AppTextStyles.textStyle2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Kondisi: Menampilkan indikator loading
                            if (state.isLoading)
                              const Center(
                                child: CircularProgressIndicator(),
                              )
                            else if (state.news.isEmpty)
                              // Jika news kosong
                              const Center(
                                child: Text(
                                  "No news available",
                                  style: TextStyle(color: AppColors.textColor),
                                ),
                              )
                            else
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.news.length,
                                itemBuilder: (context, index) {
                                  final newsItem = state.news[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailNewsPage(
                                              newsItem: newsItem),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      margin: const EdgeInsets.only(
                                        bottom: 28,
                                        left: 20,
                                        right: 20,
                                      ),
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: SizedBox(
                                        height: 100,
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(18),
                                                bottomLeft: Radius.circular(18),
                                              ),
                                              child: Image.network(
                                                newsItem.linkImage,
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
                                                children: [
                                                  Text(
                                                    newsItem.title,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    newsItem.content,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            SizedBox(
                              height: 80,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        final user = state.profile;

                        return Builder(
                          builder: (context) {
                            return CustomHeaderContainer(
                              displayText: appState.isAlreadyLogin
                                  ? user?.profile?.fullname ?? ''
                                  : 'User',
                              isLoggedIn: appState.isAlreadyLogin,
                              showText: true,
                              onMenuPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                              onNotificationPressed: () {},
                              children: [
                                if (app)
                                  Text(
                                    'Selamat datang di Lingkunganku, aplikasi untuk terhubung dengan warga dan menjaga lingkungan.',
                                    style: AppTextStyles.textWelcome,
                                    textAlign: TextAlign.center,
                                  )
                                else
                                  CustomButton(
                                    text: 'Yuk registrasi baru !',
                                    onPressed: () {
                                      showRegisterDialog(context);
                                    },
                                  ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 10,
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

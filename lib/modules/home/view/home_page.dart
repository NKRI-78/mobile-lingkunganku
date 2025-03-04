import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../misc/theme.dart';
import 'package:shimmer/shimmer.dart';
import '../../../misc/colors.dart';
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
    return BlocProvider.value(
      value: getIt<HomeBloc>()..add(HomeInit(context: context)),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'assets/images/contoh.png',
      'assets/images/contoh.png',
      'assets/images/contoh.png',
    ];

    return BlocBuilder<AppBloc, AppState>(
      builder: (context, appState) {
        final bool isLoggedIn = appState.isAlreadyLogin;
        return BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Scaffold(
              body: RefreshIndicator(
                color: AppColors.secondaryColor,
                onRefresh: () async {
                  getIt<HomeBloc>().add(HomeInit(context: context));
                  await Future.delayed(const Duration(seconds: 1));
                },
                child: Stack(
                  children: [
                    const CustomBackground(),
                    CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 295),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                child: CarouselSlider(
                                  options: CarouselOptions(
                                    height: 150,
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    viewportFraction: 1,
                                  ),
                                  items: imgList.map(
                                    (item) {
                                      return ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        child: Image.asset(
                                          item,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                            imageDefault,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                              SizedBox(height: 15),

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
                                        ShowMoreNewsRoute().go(context);
                                      },
                                      child: Text(
                                        "See all",
                                        style: AppTextStyles.textStyle2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Loading, Empty, or Showing News
                              if (state.isLoading)
                                const Center(
                                    child: CircularProgressIndicator(
                                  color: AppColors.secondaryColor,
                                ))
                              else if (state.news.isEmpty)
                                const Center(
                                  heightFactor: 5,
                                  child: Text(
                                    "Tidak ada Berita..",
                                    style: TextStyle(
                                        color: AppColors.blackNewsColor),
                                  ),
                                )
                              else
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.news.take(5).length,
                                  itemBuilder: (context, index) {
                                    final newsItem = state.news[index];
                                    return GestureDetector(
                                      onTap: () {
                                        if (newsItem.id != null) {
                                          NewsDetailRoute(newsId: newsItem.id!)
                                              .go(context);
                                        }
                                      },
                                      child: Card(
                                        margin: const EdgeInsets.only(
                                            right: 18, left: 18, bottom: 25),
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        child: SizedBox(
                                          height: 100,
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius: const BorderRadius
                                                    .horizontal(
                                                  left: Radius.circular(18),
                                                ),
                                                child: Image.network(
                                                  newsItem.linkImage,
                                                  fit: BoxFit.cover,
                                                  width: 150,
                                                  height: 150,
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      Image.asset(
                                                    'assets/images/no_image.png',
                                                    fit: BoxFit.cover,
                                                    width: 150,
                                                    height: 150,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 3),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        newsItem.title,
                                                        style: AppTextStyles
                                                            .textDialog,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        newsItem.content,
                                                        style: AppTextStyles
                                                            .textWelcome,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              const SizedBox(height: 80),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Header Section
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          final user = state.profile;

                          return CustomHeaderContainer(
                            isLoading: state.isLoading,
                            avatarLink: user?.profile?.avatarLink ?? '',
                            displayText: isLoggedIn
                                ? user?.profile?.fullname ?? ''
                                : 'User',
                            isLoggedIn: isLoggedIn,
                            showText: true,
                            onMenuPressed: () =>
                                Scaffold.of(context).openDrawer(),
                            onNotificationPressed: () {
                              //
                            },
                            children: [
                              if (isLoggedIn)
                                state.isLoading
                                    ? _buildShimmerText()
                                    : Text(
                                        "Anda masuk sebagai ${state.profile?.translateRoleApp ?? ''},\nLingkungan ${state.profile?.neighborhood?.name ?? ''}",
                                        style:
                                            AppTextStyles.textDialog.copyWith(
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                              else
                                CustomButton(
                                  text: 'Yuk Registrasi Baru !',
                                  onPressed: () => showRegisterDialog(context),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                    // Bottom Navigation Bar
                    Positioned(
                      bottom: 10,
                      left: 20,
                      right: 20,
                      child: BottomNavBarSection(
                        currentIndex: state.selectedIndex,
                        onTap: (index) {
                          if (index == 4) {
                            SosRoute(isLoggedIn: isLoggedIn).go(context);
                          }
                          context.read<HomeBloc>().add(HomeNavigate(index));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              drawer: const DrawerSection(),
            );
          },
        );
      },
    );
  }
}

// Fungsi untuk membuat efek shimmer
Widget _buildShimmerText() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Column(
      children: [
        Container(
          width: 200,
          height: 16,
          color: Colors.white,
        ),
        const SizedBox(height: 4),
        Container(
          width: 180,
          height: 16,
          color: Colors.white,
        ),
      ],
    ),
  );
}

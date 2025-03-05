import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/modules/home/widget/custom_banner_section.dart';
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
                              SizedBox(height: 290),
                              CustomBannerSection(),
                              SizedBox(height: 15),
                              buildNewsSection(state, context),
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
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: 110,
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(18),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                18)),
                                                child: Image.network(
                                                  newsItem.linkImage,
                                                  fit: BoxFit.cover,
                                                  width: 170,
                                                  height: 170,
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      Image.asset(
                                                    'assets/images/no_image.png',
                                                    fit: BoxFit.cover,
                                                    width: 170,
                                                    height: 170,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 5.0,
                                                      horizontal: 5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        newsItem.title,
                                                        style: AppTextStyles
                                                            .textDialog,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        newsItem.content.replaceAll(
                                                            RegExp(
                                                                r'<[^>]*>|&[^;]+;'),
                                                            ""),
                                                        maxLines: 2,
                                                        style: AppTextStyles
                                                            .textWelcome,
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

// Tambahkan di bagian sebelum ListView.builder
Widget buildNewsSection(HomeState state, BuildContext context) {
  final userRole = state.profile?.roleApp ?? '';
  final bool isLeaderOrSecretary =
      userRole == "CHIEF" || userRole == "SEKRETARIS";

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (isLeaderOrSecretary)
          GestureDetector(
            onTap: () {
              NewsCreateRoute().push(context);
            },
            child: Text(
              "Create",
              style: AppTextStyles.textStyle2,
            ),
          ),
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
  );
}

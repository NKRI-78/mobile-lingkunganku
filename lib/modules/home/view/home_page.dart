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
import '../widget/custom_news_card_section.dart';
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
                              SizedBox(height: 285),
                              CustomBannerSection(),
                              SizedBox(height: 10),
                              buildNewsSection(state, context),
                              if (state.isLoading)
                                const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.secondaryColor,
                                  ),
                                )
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
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.news.take(5).length,
                                  itemBuilder: (context, index) {
                                    final newsItem = state.news[index];

                                    return CustomNewsCard(
                                      imageUrl: newsItem.linkImage,
                                      title: newsItem.title,
                                      content: newsItem.content,
                                      onTap: () {
                                        if (newsItem.id != null) {
                                          NewsDetailRoute(newsId: newsItem.id!)
                                              .go(context);
                                        }
                                      },
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
                            isHomeOrPublic: true,
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
                              NotificationRoute().go(context);
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
      userRole == "CHIEF" || userRole == "SECRETARY";

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

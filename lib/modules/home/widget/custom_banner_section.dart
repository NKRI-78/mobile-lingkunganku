import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_lingkunganku/router/builder.dart';
import 'package:mobile_lingkunganku/widgets/image/image_card.dart';

import '../bloc/home_bloc.dart';

int currentIndexMultipleImg = 0;

class CustomBannerSection extends StatelessWidget {
  const CustomBannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) => previous.banner != current.banner,
        builder: (context, state) {
          if (state.banner?.data == null || state.banner!.data!.isEmpty) {
            return _buildPlaceholder();
          }

          return CarouselSlider.builder(
            options: CarouselOptions(
              height: 155,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1,
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
              initialPage: 0,
              aspectRatio: 16 / 9,
              onPageChanged: (int i, CarouselPageChangedReason reason) {
                currentIndexMultipleImg = i;
              },
            ),
            itemCount: state.banner!.data!.length,
            itemBuilder: (context, index, realIndex) {
              final data = state.banner!.data![index];

              return InkWell(
                onTap: () {
                  if (data.linkBanner != "-" && data.linkBanner!.isNotEmpty) {
                    WebViewRoute(
                            url: data.linkBanner ?? "", title: data.title ?? "")
                        .push(context);
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: ImageCard(
                    image: data.linkImage ?? '',
                    height: 180,
                    radius: 16,
                    width: double.infinity,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Placeholder jika data kosong atau null
  Widget _buildPlaceholder() {
    return Container(
      height: 155,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Text(
        "Tidak ada banner tersedia",
        style: TextStyle(color: Colors.black54, fontSize: 14),
      ),
    );
  }
}

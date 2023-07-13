import 'package:flutter/material.dart';
import 'package:nike_ecommerce_app/common/utils.dart';
import 'package:nike_ecommerce_app/data/banner.dart';
import 'package:nike_ecommerce_app/ui/widgets/image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  final PageController _sliderController = PageController();
  final List<BannerEntity> banners;

  BannerSlider({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AspectRatio(
        aspectRatio: 2,
        child: PageView.builder(
          controller: _sliderController,
          itemCount: banners.length,
          physics: defaultScrollPhysics,
          itemBuilder: (context, index) {
            return _Slide(banner: banners[index]);
          },
        ),
      ),
      Positioned(
        left: 0,
        bottom: 10,
        right: 0,
        child: Center(
          child: SmoothPageIndicator(
            controller: _sliderController,
            count: banners.length,
            axisDirection: Axis.horizontal,
            effect: WormEffect(
              spacing: 4,
              radius: 4,
              dotWidth: 18,
              dotHeight: 3,
              paintStyle: PaintingStyle.fill,
              dotColor: Colors.grey.shade400,
              activeDotColor: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
      )
    ]);
  }
}

class _Slide extends StatelessWidget {
  const _Slide({
    super.key,
    required this.banner,
  });

  final BannerEntity banner;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: ImageLoadingService(imageUrl: banner.imageUrl),
    );
  }
}

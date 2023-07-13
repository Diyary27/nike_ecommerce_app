import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_app/common/utils.dart';
import 'package:nike_ecommerce_app/data/product.dart';
import 'package:nike_ecommerce_app/data/repo/banner_repository.dart';
import 'package:nike_ecommerce_app/data/repo/product_repository.dart';
import 'package:nike_ecommerce_app/ui/home/bloc/home_bloc.dart';
import 'package:nike_ecommerce_app/ui/widgets/image.dart';
import 'package:nike_ecommerce_app/ui/widgets/slider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeBloc = HomeBloc(
            bannerRepository: bannerRepository,
            productRepository: productRepository);
        homeBloc.add(HomeStarted());
        return homeBloc;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeSuccess) {
                return ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                            child: Image.asset(
                              'assets/img/nike_logo.png',
                              height: 24,
                            ),
                          );
                        case 2:
                          return BannerSlider(banners: state.banners);
                        case 3:
                          return _ProductsList(
                            title: 'جدیدترین محصولات',
                            products: state.latestProducts,
                          );
                        case 4:
                          return _ProductsList(
                            title: 'مشهورترین محصولات',
                            products: state.popularProducts,
                          );
                        default:
                          return Container();
                      }
                    });
              } else if (state is HomeLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is HomeError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.exception.message),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                        },
                        child: Text('تلاش دوباره'),
                      )
                    ],
                  ),
                );
              } else {
                throw Exception('State is not Supported');
              }
            },
          ),
        ),
      ),
    );
  }
}

class _ProductsList extends StatelessWidget {
  final String title;
  final List<ProductEntity> products;
  _ProductsList({
    super.key,
    required this.title,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextButton(
                onPressed: () {},
                child: Text('مشاهده همه'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 290,
          child: ListView.builder(
            itemCount: products.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final product = products[index];
              return Padding(
                padding: const EdgeInsets.all(5),
                child: SizedBox(
                  width: 176,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 176,
                            height: 189,
                            child:
                                ImageLoadingService(imageUrl: product.imageUrl),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Icon(
                                CupertinoIcons.heart,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.title),
                            SizedBox(height: 5),
                            Text(
                              product.discount.withPriceLabel,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      decoration: TextDecoration.lineThrough),
                            ),
                            SizedBox(height: 2),
                            Text(product.price.withPriceLabel),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

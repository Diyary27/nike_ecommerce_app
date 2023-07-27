import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_app/common/utils.dart';
import 'package:nike_ecommerce_app/data/product.dart';
import 'package:nike_ecommerce_app/data/repo/banner_repository.dart';
import 'package:nike_ecommerce_app/data/repo/product_repository.dart';
import 'package:nike_ecommerce_app/ui/home/bloc/home_bloc.dart';
import 'package:nike_ecommerce_app/ui/product/product.dart';
import 'package:nike_ecommerce_app/ui/widgets/error.dart';
import 'package:nike_ecommerce_app/ui/widgets/slider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RefreshController _refreshController = RefreshController();
  HomeBloc? homeBloc;
  StreamSubscription? streamSubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    homeBloc?.close();
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) {
        final bloc = HomeBloc(
            bannerRepository: bannerRepository,
            productRepository: productRepository);
        homeBloc = bloc;
        streamSubscription = bloc.stream.listen((state) {
          if (_refreshController.isRefresh) {
            if (state is HomeSuccess) {
              _refreshController.refreshCompleted();
            }
          }
        });
        bloc.add(HomeStarted(isRefresh: false));

        return bloc;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeSuccess) {
                return SmartRefresher(
                  controller: _refreshController,
                  onRefresh: () {
                    BlocProvider.of<HomeBloc>(context)
                        .add(HomeStarted(isRefresh: true));
                  },
                  header: ClassicHeader(
                    completeText: 'با موفقیت به روز شد',
                    refreshingText: 'در حال به روز رسانی',
                    idleText: 'برای به روز رسانی پایین بکشید',
                    releaseText: 'رها کنید',
                    failedText: 'خطا در به روز رسانی',
                    spacing: 3,
                  ),
                  child: ListView.builder(
                      physics: defaultScrollPhysics,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(12, 16, 12, 16),
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
                      }),
                );
              } else if (state is HomeLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is HomeError) {
                return AppErrorWidget(
                  exception: state.exception,
                  onPressed: () {
                    BlocProvider.of<HomeBloc>(context)
                        .add(HomeStarted(isRefresh: false));
                  },
                );
              } else {
                // throw Exception('State is not Supported');
                debugPrint(state.toString());

                return Text('data');
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
              return ProductItem(
                  product: product, borderRadius: BorderRadius.circular(12));
            },
          ),
        ),
      ],
    );
  }
}

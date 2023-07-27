part of 'home_bloc.dart';

abstract class HomeState {
  const HomeState();
}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final AppException exception;
  const HomeError({required this.exception});
}

class HomeSuccess extends HomeState {
  final List<BannerEntity> banners;
  final List<ProductEntity> latestProducts;
  final List<ProductEntity> popularProducts;

  HomeSuccess(
      {required this.banners,
      required this.latestProducts,
      required this.popularProducts});
}

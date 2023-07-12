import 'package:dio/dio.dart';
import 'package:nike_ecommerce_app/data/banner.dart';
import 'package:nike_ecommerce_app/data/common/http_response_validator.dart';

abstract class IBannerDataSource {
  Future<List<BannerEntity>> getAll();
}

class BannerRemoteDataSource with HttpResponse implements IBannerDataSource {
  final Dio httpClient;

  BannerRemoteDataSource(this.httpClient);

  @override
  Future<List<BannerEntity>> getAll() async {
    final response = await httpClient.get('banner/slider');
    validateResponse(response);

    final List<BannerEntity> banners = [];
    (response.data as List).forEach((element) {
      banners.add(BannerEntity.fromJson(element));
    });
    return banners;
  }
}
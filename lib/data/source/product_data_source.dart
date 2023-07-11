import 'package:dio/dio.dart';
import 'package:nike_ecommerce_app/data/common/http_response_validator.dart';
import 'package:nike_ecommerce_app/data/product.dart';

abstract class IProductDataSource {
  Future<List<ProductEntity>> getAll(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductReomteDataSource with HttpResponse implements IProductDataSource {
  final Dio httpClient;

  ProductReomteDataSource(this.httpClient);

  @override
  Future<List<ProductEntity>> getAll(int sort) async {
    final response = await httpClient.get('product/list?sort=$sort');

    validateResponse(response);

    final products = <ProductEntity>[];

    (response.data as List).forEach((element) {
      products.add(ProductEntity.fromJson(element));
    });

    return products;
  }

  @override
  Future<List<ProductEntity>> search(String searchTerm) async {
    final response = await httpClient.get('product/list?sort=$searchTerm');

    validateResponse(response);

    final products = <ProductEntity>[];

    (response.data as List).forEach((element) {
      products.add(ProductEntity.fromJson(element));
    });

    return products;
  }
}

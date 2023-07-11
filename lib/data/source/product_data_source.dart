import 'package:dio/dio.dart';
import 'package:nike_ecommerce_app/common/exceptions.dart';
import 'package:nike_ecommerce_app/data/product.dart';

abstract class IProductDataSource {
  Future<List<ProductEntity>> getAll(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductReomteDataSource implements IProductDataSource {
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

  validateResponse(Response response) {
    if (response.statusCode != 200) {
      throw AppException();
    }
  }
}

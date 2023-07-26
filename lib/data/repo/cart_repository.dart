import 'package:nike_ecommerce_app/common/http_client.dart';
import 'package:nike_ecommerce_app/data/cart_item.dart';
import 'package:nike_ecommerce_app/data/add_to_cart_response.dart';
import 'package:nike_ecommerce_app/data/cart_response.dart';
import 'package:nike_ecommerce_app/data/source/cart_data_source.dart';

final cartRepository = CartRepository(CartRemoteDataSource(httpClient));

abstract class ICartRepository {
  Future<AddToCartResponse> add(int productId);
  Future<void> remove(int cartItemId);
  Future<AddToCartResponse> changeCount(int cartItemId, int count);
  Future<int> count();
  Future<CartResponse> getAll();
}

class CartRepository implements ICartRepository {
  final ICartDataSource dataSource;

  CartRepository(this.dataSource);
  @override
  Future<AddToCartResponse> add(int productId) => dataSource.add(productId);

  @override
  Future<AddToCartResponse> changeCount(int cartItemId, int count) =>
      dataSource.changeCount(cartItemId, count);

  @override
  Future<int> count() {
    // TODO: implement count
    throw UnimplementedError();
  }

  @override
  Future<CartResponse> getAll() => dataSource.getAll();

  @override
  Future<void> remove(int cartItemId) => dataSource.remove(cartItemId);
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nike_ecommerce_app/data/cart_item.dart';
import 'package:nike_ecommerce_app/data/cart_response.dart';
import 'package:nike_ecommerce_app/data/common/http_response_validator.dart';
import 'package:nike_ecommerce_app/data/repo/auth_repository.dart';

abstract class ICartDataSource {
  Future<CartResponse> add(int productId);
  Future<void> remove(int cartItemId);
  Future<CartResponse> changeCount(int cartItemId, int count);
  Future<int> count();
  Future<List<CartItemEntity>> getAll();
}

class CartRemoteDataSource
    with HttpResponseValidator
    implements ICartDataSource {
  final Dio httpClient;

  CartRemoteDataSource(this.httpClient);

  @override
  Future<CartResponse> add(int productId) async {
    // debugPrint(AuthRepository.authChangeNotifier.value?.accessToken);
    final response = await httpClient.post('cart/add', data: {
      "product_id": productId,
    });
    validateResponse(response);
    return CartResponse.fromJson(response.data);
  }

  @override
  Future<CartResponse> changeCount(int cartItemId, int count) {
    // TODO: implement changeCount
    throw UnimplementedError();
  }

  @override
  Future<int> count() async {
    final response = await httpClient.get('cart/count');
    validateResponse(response);
    return response.data;
  }

  @override
  Future<List<CartItemEntity>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<void> remove(int cartItemId) async {
    final response = await httpClient.post(
      'cart/remove',
      data: {"cart_item_id": cartItemId},
    );
    validateResponse(response);
  }
}

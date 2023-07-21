import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nike_ecommerce_app/data/cart_item.dart';
import 'package:nike_ecommerce_app/data/add_to_cart_response.dart';
import 'package:nike_ecommerce_app/data/cart_response.dart';
import 'package:nike_ecommerce_app/data/common/http_response_validator.dart';
import 'package:nike_ecommerce_app/data/repo/auth_repository.dart';

abstract class ICartDataSource {
  Future<AddToCartResponse> add(int productId);
  Future<void> remove(int cartItemId);
  Future<AddToCartResponse> changeCount(int cartItemId, int count);
  Future<int> count();
  Future<CartResponse> getAll();
}

class CartRemoteDataSource
    with HttpResponseValidator
    implements ICartDataSource {
  final Dio httpClient;

  CartRemoteDataSource(this.httpClient);

  @override
  Future<AddToCartResponse> add(int productId) async {
    // debugPrint(AuthRepository.authChangeNotifier.value?.accessToken);
    final response = await httpClient.post('cart/add', data: {
      "product_id": productId,
    });
    validateResponse(response);
    return AddToCartResponse.fromJson(response.data);
  }

  @override
  Future<AddToCartResponse> changeCount(int cartItemId, int count) {
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
  Future<CartResponse> getAll() async {
    final response = await httpClient.get('cart/list');
    validateResponse(response);

    return CartResponse.fromJson(response.data);
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nike_ecommerce_app/data/repo/auth_repository.dart';
import 'package:nike_ecommerce_app/data/repo/cart_repository.dart';
import 'package:nike_ecommerce_app/ui/auth/auth.dart';
import 'package:nike_ecommerce_app/ui/cart/bloc/cart_bloc.dart';
import 'package:nike_ecommerce_app/ui/cart/cart_item.dart';
import 'package:nike_ecommerce_app/ui/cart/price_info.dart';
import 'package:nike_ecommerce_app/ui/shipping/shipping.dart';
import 'package:nike_ecommerce_app/ui/widgets/empty_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartBloc? cartBloc;
  final RefreshController _refreshController = RefreshController();
  StreamSubscription? stateStreamSubscription;
  bool isSuccessState = false;

  @override
  void initState() {
    super.initState();
    AuthRepository.authChangeNotifier.addListener(authChangeNotifierListener);
  }

  void authChangeNotifierListener() {
    cartBloc?.add(CartAuthChangedInfo(AuthRepository.authChangeNotifier.value));
  }

  @override
  void dispose() {
    AuthRepository.authChangeNotifier
        .removeListener(authChangeNotifierListener);
    cartBloc?.close();
    stateStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        appBar: AppBar(
          centerTitle: true,
          title: Text('سبد خرید'),
        ),
        floatingActionButton: Container(
          width: MediaQuery.of(context).size.width - 100,
          child: Visibility(
            visible: isSuccessState,
            child: FloatingActionButton.extended(
              onPressed: () {
                final state = cartBloc?.state;
                if (state is CartSuccess) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ShippingScreen(
                          totalPrice: state.cartResponse.totalPrice,
                          shippingCost: state.cartResponse.shippingCost,
                          payablePrice: state.cartResponse.payablePrice)));
                }
              },
              label: Text('پرداخت'),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: BlocProvider<CartBloc>(
          create: (context) {
            final bloc = CartBloc(cartRepository);

            stateStreamSubscription = bloc.stream.listen((state) {
              setState(() {
                isSuccessState = state is CartSuccess;
              });
              if (_refreshController.isRefresh) {
                if (state is CartSuccess) {
                  _refreshController.refreshCompleted();
                }
              }
            });
            cartBloc = bloc;
            bloc.add(CartStarted(AuthRepository.authChangeNotifier.value));
            return bloc;
          },
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                return CircularProgressIndicator();
              } else if (state is CartError) {
                return Center(
                  child: Text(state.exception.message),
                );
              } else if (state is CartSuccess) {
                return SmartRefresher(
                  controller: _refreshController,
                  onRefresh: () {
                    cartBloc!.add(
                        CartStarted(AuthRepository.authChangeNotifier.value));
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
                    padding: EdgeInsets.only(bottom: 60),
                    itemCount: state.cartResponse.carts.length + 1,
                    itemBuilder: (context, index) {
                      if (index < state.cartResponse.carts.length) {
                        final cartItem = state.cartResponse.carts[index];
                        return CartItem(
                          cartItem: cartItem,
                          onDeleteButtonClick: () {
                            cartBloc?.add(
                                CartDeleteButtonClicked(cartItem.cartItemId));
                          },
                          onDecreaseButtonClick: () {
                            if (cartItem.count > 1) {
                              cartBloc?.add(CartDecreaseButtonClicked(
                                  cartItem.cartItemId));
                            }
                          },
                          onIncreaseButtonClick: () {
                            if (cartItem.count < 5) {
                              cartBloc?.add(CartIncreaseButtonClicked(
                                  cartItem.cartItemId));
                            }
                          },
                        );
                      } else {
                        return PriceInfo(
                          payablePrice: state.cartResponse.payablePrice,
                          shippingCost: state.cartResponse.shippingCost,
                          totalPrice: state.cartResponse.totalPrice,
                        );
                      }
                    },
                  ),
                );
              } else if (state is CartAuthRequired) {
                return EmptyView(
                    message:
                        'برای مشاهده سبد خرید لطفا ابتدا وارد حساب کاربری خود شوید',
                    image: SvgPicture.asset(
                      "assets/img/auth_required.svg",
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                    callToAction: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => AuthScreen())));
                      },
                      child: Text('ورود'),
                    ));
              } else if (state is CartEmpty) {
                return EmptyView(
                  message:
                      'شما هنوز هیچ محصولی به سبد خرید خود اضافه نکرده اید',
                  image: SvgPicture.asset(
                    "assets/img/empty_cart.svg",
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                );
              } else {
                throw Exception('state unsuported');
              }
            },
          ),
        ));
  }
}

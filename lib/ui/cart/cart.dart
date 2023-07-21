import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_app/common/utils.dart';
import 'package:nike_ecommerce_app/data/repo/auth_repository.dart';
import 'package:nike_ecommerce_app/data/repo/cart_repository.dart';
import 'package:nike_ecommerce_app/ui/auth/auth.dart';
import 'package:nike_ecommerce_app/ui/cart/bloc/cart_bloc.dart';
import 'package:nike_ecommerce_app/ui/widgets/image.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartBloc? cartBloc;

  void authChangeNotifierListener() {
    cartBloc?.add(CartAuthChangedInfo(AuthRepository.authChangeNotifier.value));
  }

  @override
  void initState() {
    super.initState();
    AuthRepository.authChangeNotifier.addListener(authChangeNotifierListener);
  }

  @override
  void dispose() {
    AuthRepository.authChangeNotifier.addListener(authChangeNotifierListener);
    cartBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('سبد خرید'),
        ),
        body: BlocProvider<CartBloc>(
          create: (context) {
            final bloc = CartBloc(cartRepository);
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
                return ListView.builder(
                  itemCount: state.cartResponse.carts.length,
                  itemBuilder: (context, index) {
                    final cartItem = state.cartResponse.carts[index];
                    return Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12.withOpacity(0.05),
                              blurRadius: 2)
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 100,
                                  child: ImageLoadingService(
                                      imageUrl: cartItem.product.imageUrl),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(cartItem.product.title),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text('تعداد'),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon:
                                              Icon(CupertinoIcons.plus_square)),
                                      Text(cartItem.count.toString()),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                              CupertinoIcons.minus_square)),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(cartItem
                                      .product.previousPrice.withPriceLabel),
                                  Text(cartItem.product.price.withPriceLabel),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            height: 1,
                          ),
                          TextButton(
                              onPressed: () {}, child: Text('حذف از سبد خرید')),
                        ],
                      ),
                    );
                  },
                );
              } else if (state is CartAuthRequired) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text('لطفا وارد حساب کاربری خود شوید'),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AuthScreen()));
                        },
                        child: Text('ورود')),
                  ],
                );
              } else {
                throw Text('state unsuported');
              }
            },
          ),
        ));
  }
}

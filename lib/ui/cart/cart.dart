import 'package:flutter/material.dart';
import 'package:nike_ecommerce_app/data/repo/auth_repository.dart';
import 'package:nike_ecommerce_app/data/repo/cart_repository.dart';
import 'package:nike_ecommerce_app/ui/auth/auth.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('سبد خرید'),
      ),
      body: ValueListenableBuilder(
        valueListenable: AuthRepository.authChangeNotifier,
        builder: (context, authState, child) {
          final isAuthorized =
              authState != null && authState!.accessToken.isNotEmpty;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(isAuthorized
                  ? 'خوش آمدید'
                  : 'لطفا وارد حساب کاربری خود شوید'),
              isAuthorized
                  ? ElevatedButton(
                      onPressed: () {
                        authRepository.signOut();
                      },
                      child: Text('خروج'),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (context) => AuthScreen()));
                      },
                      child: Text('لطفا وارد شوید'),
                    ),
              ElevatedButton(
                onPressed: () {
                  cartRepository.getAll();
                },
                child: Text('demo'),
              )
            ],
          );
        },
      ),
    );
  }
}

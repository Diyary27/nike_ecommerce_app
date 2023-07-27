import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_app/common/utils.dart';
import 'package:nike_ecommerce_app/data/repo/order_repository.dart';
import 'package:nike_ecommerce_app/theme.dart';
import 'package:nike_ecommerce_app/ui/cart/cart.dart';
import 'package:nike_ecommerce_app/ui/receipt/bloc/payment_receipt_bloc.dart';

class PaymentReceiptScreen extends StatelessWidget {
  final int orderId;
  const PaymentReceiptScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('رسید پرداخت'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) {
          final bloc = PaymentReceiptBloc(orderRepository);
          bloc.add(PaymentReceiptLoaded(orderId));
          return bloc;
        },
        child: BlocBuilder<PaymentReceiptBloc, PaymentReceiptState>(
          builder: (context, state) {
            if (state is PaymentReceiptError) {
              return Center(child: Text(state.exception.message));
            } else if (state is PaymentReceiptLoading) {
              return Center(child: CupertinoActivityIndicator());
            } else if (state is PaymentReceiptSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: themeData.dividerColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 16),
                            child: Text(
                              state.paymentReceiptData.purchaseSuccess
                                  ? 'پرداخت با موفقیت انجام شد'
                                  : 'پرداخت ناموفق',
                              style: themeData.textTheme.titleLarge!
                                  .apply(color: themeData.colorScheme.primary),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'وضعیت سفارش',
                                  style: TextStyle(
                                      color:
                                          LightThemeColors.secondaryTextColor),
                                ),
                                Text(
                                  state.paymentReceiptData.paymentStatus,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(height: 1),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'مبلغ',
                                  style: TextStyle(
                                      color:
                                          LightThemeColors.secondaryTextColor),
                                ),
                                Text(
                                  state.paymentReceiptData.payablePrice
                                      .withPriceLabel,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: Text('بازگشت به صفحه اصلی'),
                  )
                ],
              );
            } else {
              return Text('state not supported');
            }
          },
        ),
      ),
    );
  }
}

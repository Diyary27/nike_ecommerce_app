import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_app/data/order.dart';
import 'package:nike_ecommerce_app/data/repo/order_repository.dart';
import 'package:nike_ecommerce_app/ui/cart/price_info.dart';
import 'package:nike_ecommerce_app/ui/payment_webview.dart';
import 'package:nike_ecommerce_app/ui/receipt/payment_receipt.dart';
import 'package:nike_ecommerce_app/ui/shipping/bloc/shipping_bloc.dart';

class ShippingScreen extends StatelessWidget {
  final int totalPrice;
  final int shippingCost;
  final int payablePrice;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  ShippingScreen(
      {super.key,
      required this.totalPrice,
      required this.shippingCost,
      required this.payablePrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('انتخاب تحویل گیرنده و شیوه پرداخت'),
        centerTitle: false,
      ),
      body: BlocProvider(
        create: (context) {
          final bloc = ShippingBloc(orderRepository);
          bloc.stream.listen((state) {
            if (state is ShippingSuccess) {
              if (state.result.bankGateWayUrl.isNotEmpty) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PaymentGateWayScreen(
                        bankGateWayUrl: state.result.bankGateWayUrl)));
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PaymentReceiptScreen(
                          orderId: state.result.orderId,
                        )));
              }
            } else if (state is ShippingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.exception.message)));
            }
          });
          return bloc;
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                label: Text('نام'),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                label: Text('نام خانوادگی'),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                label: Text('شماره تماس'),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _postalCodeController,
              decoration: InputDecoration(
                label: Text('کد پستی'),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                label: Text('آدرس'),
              ),
            ),
            SizedBox(height: 12),
            PriceInfo(
                totalPrice: totalPrice,
                shippingCost: shippingCost,
                payablePrice: payablePrice),
            BlocBuilder<ShippingBloc, ShippingState>(
              builder: (context, state) {
                return state is ShippingLoading
                    ? Center(child: CupertinoActivityIndicator())
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                              onPressed: () {
                                BlocProvider.of<ShippingBloc>(context)
                                    .add(ShippingCreateOrder(CreateOrderParams(
                                  _firstNameController.text,
                                  _lastNameController.text,
                                  _phoneController.text,
                                  _postalCodeController.text,
                                  _addressController.text,
                                  PaymentMethod.cashOnDelivery,
                                )));
                              },
                              child: Text('پرداخت در محل')),
                          SizedBox(width: 10),
                          ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<ShippingBloc>(context)
                                    .add(ShippingCreateOrder(CreateOrderParams(
                                  _firstNameController.text,
                                  _lastNameController.text,
                                  _phoneController.text,
                                  _postalCodeController.text,
                                  _addressController.text,
                                  PaymentMethod.online,
                                )));
                              },
                              child: Text('پرداخت آنلاین')),
                        ],
                      );
              },
            ),
          ]),
        ),
      ),
    );
  }
}

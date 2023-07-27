import 'package:flutter/material.dart';
import 'package:nike_ecommerce_app/ui/cart/price_info.dart';

class ShippingScreen extends StatelessWidget {
  final int totalPrice;
  final int shippingCost;
  final int payablePrice;

  const ShippingScreen(
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            decoration: InputDecoration(
              label: Text('نام و نام خانوادگی'),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              label: Text('شماره تماس'),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              label: Text('کد پستی'),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              label: Text('آدرس'),
            ),
          ),
          SizedBox(height: 12),
          PriceInfo(
              totalPrice: totalPrice,
              shippingCost: shippingCost,
              payablePrice: payablePrice),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(onPressed: () {}, child: Text('پرداخت در محل')),
              SizedBox(width: 10),
              ElevatedButton(onPressed: () {}, child: Text('پرداخت آنلاین')),
            ],
          ),
        ]),
      ),
    );
  }
}

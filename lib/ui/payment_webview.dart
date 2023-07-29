import 'package:flutter/material.dart';
import 'package:nike_ecommerce_app/ui/receipt/payment_receipt.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentGateWayScreen extends StatelessWidget {
  final String bankGateWayUrl;
  WebViewController _webViewController = WebViewController();

  PaymentGateWayScreen({super.key, required this.bankGateWayUrl});

  @override
  Widget build(BuildContext context) {
    _webViewController
      ..loadRequest(Uri.parse(bankGateWayUrl))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          final uri = Uri.parse(url);
          if (uri.pathSegments.contains('appCheckout') &&
              uri.host == 'expertdevelopers.ir') {
            final orderId = int.parse(uri.queryParameters['order_id']!);
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PaymentReceiptScreen(orderId: orderId)));
          }
        },
      ));

    return WebViewWidget(
      controller: _webViewController,
    );
  }
}

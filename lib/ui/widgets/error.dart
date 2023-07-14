import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_app/common/exceptions.dart';
import 'package:nike_ecommerce_app/ui/home/bloc/home_bloc.dart';

class AppErrorWidget extends StatelessWidget {
  final GestureTapCallback onPressed;
  final AppException exception;

  const AppErrorWidget({
    super.key,
    required this.exception,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(exception.message),
          ElevatedButton(
            onPressed: onPressed,
            child: Text('تلاش دوباره'),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final String message;
  final Widget image;
  final Widget? callToAction;

  const EmptyView(
      {super.key,
      required this.message,
      required this.image,
      this.callToAction});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        image,
        Padding(
          padding: const EdgeInsets.all(25),
          child: Text(
            message,
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(height: 1.3),
            textAlign: TextAlign.center,
          ),
        ),
        if (callToAction != null) callToAction!,
      ],
    );
  }
}

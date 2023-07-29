import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nike_ecommerce_app/common/utils.dart';
import 'package:nike_ecommerce_app/data/product.dart';
import 'package:nike_ecommerce_app/ui/product/details.dart';
import 'package:nike_ecommerce_app/ui/widgets/image.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.borderRadius,
  });

  final ProductEntity product;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(product: product)));
        },
        borderRadius: borderRadius,
        child: SizedBox(
          width: 176,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 0.93,
                    child: ImageLoadingService(
                      imageUrl: product.imageUrl,
                      borderRadius: borderRadius,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        CupertinoIcons.heart,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.title),
                    SizedBox(height: 5),
                    Text(
                      product.previousPrice.withPriceLabel,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(decoration: TextDecoration.lineThrough),
                    ),
                    SizedBox(height: 2),
                    Text(product.price.withPriceLabel),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

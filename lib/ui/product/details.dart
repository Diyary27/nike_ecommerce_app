import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_app/common/utils.dart';
import 'package:nike_ecommerce_app/data/product.dart';
import 'package:nike_ecommerce_app/data/repo/cart_repository.dart';
import 'package:nike_ecommerce_app/ui/product/bloc/product_bloc.dart';
import 'package:nike_ecommerce_app/ui/product/comment/comment_list.dart';
import 'package:nike_ecommerce_app/ui/widgets/image.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductEntity product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  StreamSubscription<ProductState>? streamSubscription = null;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void dispose() {
    streamSubscription?.cancel();
    _scaffoldKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider<ProductBloc>(
        create: (BuildContext context) {
          final bloc = ProductBloc(cartRepository);
          streamSubscription = bloc.stream.listen((state) {
            if (state is ProductAddToCartSuccess) {
              _scaffoldKey.currentState?.showSnackBar(SnackBar(
                  content: Text('محصول با موفقیت به سبد خرید اضافه شد')));
            } else if (state is ProductAddToCartError) {
              _scaffoldKey.currentState
                  ?.showSnackBar(SnackBar(content: Text('خطای نامشحص')));
            }
          });
          return bloc;
        },
        child: ScaffoldMessenger(
          key: _scaffoldKey,
          child: Scaffold(
            floatingActionButton: SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (BuildContext context, state) {
                  return FloatingActionButton.extended(
                    onPressed: () {
                      BlocProvider.of<ProductBloc>(context)
                          .add(CartAddButtonClicked(widget.product.id));
                    },
                    label: (state is ProductAddToCartButtonLoading)
                        ? CupertinoActivityIndicator(
                            color: Theme.of(context).colorScheme.onSecondary,
                          )
                        : Text('افزودن به سبد خرید'),
                  );
                },
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: CustomScrollView(
              physics: defaultScrollPhysics,
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.width * 0.8,
                  foregroundColor: Theme.of(context).colorScheme.onBackground,
                  flexibleSpace:
                      ImageLoadingService(imageUrl: widget.product.imageUrl),
                  actions: [Icon(CupertinoIcons.heart)],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.product.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontSize: 18),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.product.previousPrice.withPriceLabel,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),
                                Text(widget.product.price.withPriceLabel),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Text(
                            'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.'),
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'نظرات کاربران',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text('ثبت نظر'),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                CommentList(productId: widget.product.id),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

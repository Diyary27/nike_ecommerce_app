import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_app/data/repo/product_repository.dart';
import 'package:nike_ecommerce_app/ui/list/bloc/product_list_bloc.dart';
import 'package:nike_ecommerce_app/ui/product/product.dart';

class ProductListScreen extends StatelessWidget {
  final int sort;

  const ProductListScreen({super.key, required this.sort});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('محصولات')),
      body: BlocProvider<ProductListBloc>(
        create: (context) =>
            ProductListBloc(productRepository)..add(ProductListStarted(sort)),
        child: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            if (state is ProductListSuccess) {
              return GridView.builder(
                  itemCount: state.products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.65,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return ProductItem(
                        product: product, borderRadius: BorderRadius.zero);
                  });
            } else if (state is ProductListLoading) {
              return Center(child: CupertinoActivityIndicator());
            } else if (state is ProductListError) {
              return Center(child: Text(state.exception.message));
            } else {
              return Center(child: Text('state is: ' + state.toString()));
            }
          },
        ),
      ),
    );
  }
}

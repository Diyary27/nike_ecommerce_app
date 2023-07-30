import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_app/data/repo/product_repository.dart';
import 'package:nike_ecommerce_app/ui/list/bloc/product_list_bloc.dart';
import 'package:nike_ecommerce_app/ui/product/product.dart';

class ProductListScreen extends StatefulWidget {
  final int sort;

  const ProductListScreen({super.key, required this.sort});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

enum ViewType {
  grid,
  list,
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductListBloc? bloc;
  ViewType viewType = ViewType.grid;

  @override
  void dispose() {
    bloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('محصولات')),
      body: BlocProvider<ProductListBloc>(
        create: (context) {
          bloc = ProductListBloc(productRepository)
            ..add(ProductListStarted(widget.sort));
          return bloc!;
        },
        child: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            if (state is ProductListSuccess) {
              return Column(
                children: [
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.black12)),
                      color: Theme.of(context).colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(22))),
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: 230,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16),
                                            child: Text(
                                              'انتخاب مرتب سازی',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(fontSize: 18),
                                            ),
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                                padding:
                                                    EdgeInsets.only(right: 12),
                                                itemCount:
                                                    state.productSort.length,
                                                itemBuilder: (context, index) {
                                                  return Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          bloc?.add(
                                                              ProductListStarted(
                                                                  index));
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            state.productSort[
                                                                index],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                      ),
                                                      if (index == state.sort)
                                                        Icon(
                                                          CupertinoIcons
                                                              .check_mark_circled,
                                                          size: 18,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                        )
                                                    ],
                                                  );
                                                }),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                              child: Row(
                                children: [
                                  Icon(CupertinoIcons.sort_down),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('مرتب سازی'),
                                        Text(
                                          state.productSort[widget.sort],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 1,
                          color: Colors.black12,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                viewType = viewType == ViewType.grid
                                    ? ViewType.list
                                    : ViewType.grid;
                              });
                            },
                            child: Icon(CupertinoIcons.square_grid_2x2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                        itemCount: state.products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.65,
                          crossAxisCount: viewType == ViewType.grid ? 2 : 1,
                        ),
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return ProductItem(
                              product: product,
                              borderRadius: BorderRadius.zero);
                        }),
                  ),
                ],
              );
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

part of 'product_list_bloc.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object> get props => [];
}

class ProductListLoading extends ProductListState {}

class ProductListSuccess extends ProductListState {
  final List<ProductEntity> products;
  final int sort;
  final List<String> productSort;

  ProductListSuccess(this.products, this.productSort, this.sort);
}

class ProductListError extends ProductListState {
  final AppException exception;

  ProductListError(this.exception);
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_ecommerce_app/common/exceptions.dart';
import 'package:nike_ecommerce_app/data/product.dart';
import 'package:nike_ecommerce_app/data/repo/product_repository.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final IProductRepository productRepository;
  ProductListBloc(this.productRepository) : super(ProductListLoading()) {
    on<ProductListEvent>((event, emit) async {
      if (event is ProductListStarted) {
        emit(ProductListLoading());
        try {
          final productList = await productRepository.getAll(event.sort);
          emit(ProductListSuccess(
              productList, ProductSort.sortNames, event.sort));
        } catch (e) {
          emit(ProductListError(AppException()));
        }
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_ecommerce_app/common/exceptions.dart';
import 'package:nike_ecommerce_app/data/auth_info.dart';
import 'package:nike_ecommerce_app/data/cart_response.dart';
import 'package:nike_ecommerce_app/data/repo/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository cartRepository;
  CartBloc(this.cartRepository) : super(CartLoading()) {
    on<CartEvent>((event, emit) async {
      if (event is CartStarted) {
        if (event.authInfo == null || event.authInfo!.accessToken.isEmpty) {
          emit(CartAuthRequired());
        } else {
          await loadCartItems(emit);
        }
      } else if (event is CartDeleteButtonClicked) {
      } else if (event is CartAuthChangedInfo) {
        if (event.authInfo == null || event.authInfo!.accessToken.isEmpty) {
          emit(CartAuthRequired());
        } else {
          if (state is CartAuthRequired) {
            await loadCartItems(emit);
          }
        }
      }
    });
  }

  Future<void> loadCartItems(Emitter<CartState> emit) async {
    try {
      final cartResponse = await cartRepository.getAll();
      if (cartResponse == null || cartResponse.carts.isEmpty) {
        emit(CartEmpty());
      } else {
        emit(CartSuccess(cartResponse));
      }
    } catch (e) {
      emit(CartError(AppException()));
    }
  }
}

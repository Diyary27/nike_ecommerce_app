part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartStarted extends CartEvent {
  final AuthInfo? authInfo;
  const CartStarted(this.authInfo);
}

class CartDeleteButtonClicked extends CartEvent {
  final int cartItemId;

  const CartDeleteButtonClicked(this.cartItemId);

  @override
  List<Object> get props => [cartItemId];
}

class CartIncreaseButtonClicked extends CartEvent {
  final int cartItemId;

  const CartIncreaseButtonClicked(this.cartItemId);

  @override
  List<Object> get props => [cartItemId];
}

class CartDecreaseButtonClicked extends CartEvent {
  final int cartItemId;

  const CartDecreaseButtonClicked(this.cartItemId);

  @override
  List<Object> get props => [cartItemId];
}

class CartAuthChangedInfo extends CartEvent {
  final AuthInfo? authInfo;

  CartAuthChangedInfo(this.authInfo);
}

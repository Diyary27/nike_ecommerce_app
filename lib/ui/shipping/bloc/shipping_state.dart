part of 'shipping_bloc.dart';

abstract class ShippingState extends Equatable {
  const ShippingState();

  @override
  List<Object> get props => [];
}

class ShippingInitial extends ShippingState {}

class ShippingLoading extends ShippingState {}

class ShippingError extends ShippingState {
  final AppException exception;

  ShippingError(this.exception);
}

class ShippingSuccess extends ShippingState {
  final CreateOrderResult result;

  ShippingSuccess(this.result);
}

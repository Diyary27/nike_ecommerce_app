part of 'payment_receipt_bloc.dart';

abstract class PaymentReceiptState extends Equatable {
  const PaymentReceiptState();

  @override
  List<Object> get props => [];
}

class PaymentReceiptInitial extends PaymentReceiptState {}

class PaymentReceiptLoading extends PaymentReceiptState {}

class PaymentReceiptSuccess extends PaymentReceiptState {
  final PaymentReceiptData paymentReceiptData;

  PaymentReceiptSuccess(this.paymentReceiptData);
}

class PaymentReceiptError extends PaymentReceiptState {
  final AppException exception;

  PaymentReceiptError(this.exception);
}

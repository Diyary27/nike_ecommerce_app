part of 'payment_receipt_bloc.dart';

abstract class PaymentReceiptEvent extends Equatable {
  const PaymentReceiptEvent();

  @override
  List<Object> get props => [];
}

class PaymentReceiptLoaded extends PaymentReceiptEvent {
  final int orderId;

  PaymentReceiptLoaded(this.orderId);
}

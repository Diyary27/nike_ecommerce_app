import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_ecommerce_app/common/exceptions.dart';
import 'package:nike_ecommerce_app/data/payment_receipt.dart';
import 'package:nike_ecommerce_app/data/repo/order_repository.dart';

part 'payment_receipt_event.dart';
part 'payment_receipt_state.dart';

class PaymentReceiptBloc
    extends Bloc<PaymentReceiptEvent, PaymentReceiptState> {
  final IOrderRepository orderRepository;
  PaymentReceiptBloc(this.orderRepository) : super(PaymentReceiptInitial()) {
    on<PaymentReceiptEvent>((event, emit) async {
      if (event is PaymentReceiptLoaded) {
        try {
          emit(PaymentReceiptLoading());
          final response =
              await orderRepository.getPaymentReceipt(event.orderId);
          emit(PaymentReceiptSuccess(response));
        } catch (e) {
          emit(PaymentReceiptError(AppException()));
        }
      }
    });
  }
}

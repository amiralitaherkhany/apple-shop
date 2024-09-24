import 'package:apple_shop/data/repository/basket_repository.dart';
import 'package:apple_shop/util/payment_handler.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentHandler paymentHandler;
  final IBasketRepository repository;

  PaymentBloc({
    required this.paymentHandler,
    required this.repository,
  }) : super(PaymentInitial()) {
    on<PaymentInitEvent>(
      (event, emit) async {
        var finalPrice = await repository.getBasketFinalPrice();

        paymentHandler.initPaymentRequest(finalPrice);
      },
    );
    on<PaymentRequestEvent>(
      (event, emit) async {
        var response = await paymentHandler.sendPaymentRequest();
        emit(PaymentResponse(response: response));
      },
    );
  }
}

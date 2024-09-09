import 'package:apple_shop/data/repository/basket_repository.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/models/card_item.dart';
import 'package:apple_shop/util/payment_handler.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IBasketRepository _repository = locator.get();
  final PaymentHandler _paymentHandler = ZarinpalPaymentHandler();
  BasketBloc() : super(BasketInitial()) {
    on<BasketFetchFromHive>((event, emit) async {
      var basketItems = await _repository.getAllBasketItems();
      var finalPrice = await _repository.getBasketFinalPrice();
      emit(BasketDataFetched(basketItems: basketItems, finalPrice: finalPrice));
    });

    on<BasketPaymentInit>(
      (event, emit) {
        _paymentHandler.initPaymentRequest();
      },
    );
    on<BasketPaymentRequest>(
      (event, emit) {
        _paymentHandler.sendPaymentRequest();
      },
    );
  }
  // @override
  // Future<void> close() async {
  //   _linkSubscription?.cancel();
  //   return super.close();
  // }
}

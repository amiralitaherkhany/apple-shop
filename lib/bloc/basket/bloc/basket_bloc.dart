import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:apple_shop/data/repository/basket_repository.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/models/card_item.dart';
import 'package:apple_shop/util/extensions/string_extensions.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zarinpal/zarinpal.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IBasketRepository _repository = locator.get();
  final PaymentRequest _paymentRequest = PaymentRequest();
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;
  BasketBloc() : super(BasketInitial()) {
    on<BasketFetchFromHive>((event, emit) async {
      var basketItems = await _repository.getAllBasketItems();
      var finalPrice = await _repository.getBasketFinalPrice();
      emit(BasketDataFetched(basketItems: basketItems, finalPrice: finalPrice));
    });

    on<BasketPaymentInit>(
      (event, emit) {
        _paymentRequest.setIsSandBox(true);
        _paymentRequest.setAmount(105600);
        _paymentRequest.setDescription('this is a test description');
        _paymentRequest.setCallbackURL('expertflutter://shop');
        _paymentRequest.setMerchantID('XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX');
      },
    );
    on<BasketPaymentRequest>(
      (event, emit) {
        ZarinPal().startPayment(
          _paymentRequest,
          (status, paymentGatewayUri) {
            if (status == 100) {
              debugPrint(Uri.parse(paymentGatewayUri!).toString());
              launchUrl(
                Uri.parse(paymentGatewayUri),
              );
            }
          },
        );

        _linkSubscription = _appLinks.uriLinkStream.listen(
          (uri) {
            debugPrint('onAppLink: $uri');
            //expertflutter://shop?Authority=132324323423443421212121212121212121&Status=OK
            if (uri.toString().toLowerCase().contains('authority')) {
              String? authority =
                  uri.toString().extractValueFromQuery('Authority');
              String? status = uri.toString().extractValueFromQuery('Status');
              debugPrint(authority);
              debugPrint(status);
              ZarinPal().verificationPayment(
                status!,
                authority!,
                _paymentRequest,
                (isPaymentSuccess, refID, paymentRequest) {
                  if (isPaymentSuccess) {
                    debugPrint(refID);
                  } else {
                    debugPrint('error');
                  }
                },
              );
            }
            _linkSubscription?.cancel();
          },
        );
      },
    );
  }
  // @override
  // Future<void> close() async {
  //   _linkSubscription?.cancel();
  //   return super.close();
  // }
}

import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:apple_shop/util/extensions/string_extensions.dart';
import 'package:apple_shop/util/url_handler.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:zarinpal/zarinpal.dart';

abstract class PaymentHandler {
  Future<void> initPaymentRequest(int price);
  Future<Either<String, bool>> sendPaymentRequest();
  Future<bool> verifyPaymentRequest();
}

class ZarinpalPaymentHandler implements PaymentHandler {
  final PaymentRequest paymentRequest;
  final UrlHandler urlHandler;
  final AppLinks appLinks;
  String? _authority;
  String? _status;

  StreamSubscription<Uri>? _linkSubscription;
  ZarinpalPaymentHandler(
      {required this.paymentRequest,
      required this.appLinks,
      required this.urlHandler});
  @override
  Future<void> initPaymentRequest(int finalPrice) async {
    paymentRequest.setIsSandBox(false);
    paymentRequest.setAmount(finalPrice);
    paymentRequest.setDescription('this is a test description');
    paymentRequest.setCallbackURL('expertflutter://shop');
    paymentRequest.setMerchantID('d645fba8-1b29-11ea-be59-000c295eb8fc');
  }

  @override
  Future<Either<String, bool>> sendPaymentRequest() async {
    Completer<Either<String, bool>> completer =
        Completer<Either<String, bool>>();
    ZarinPal().startPayment(
      paymentRequest,
      (status, paymentGatewayUri) {
        if (status == 100) {
          urlHandler.openUrl(paymentGatewayUri!);
          _linkSubscription = appLinks.uriLinkStream.listen(
            (uri) async {
              debugPrint('app opened');
              if (uri.toString().contains('Authority')) {
                _authority = uri.toString().extractValueFromQuery('Authority');
                _status = uri.toString().extractValueFromQuery('Status');
                debugPrint(_authority);
                debugPrint(_status);
                bool isPaymentSuccess = await verifyPaymentRequest();
                if (isPaymentSuccess) {
                  completer.complete(right(true));
                } else {
                  completer.complete(right(false));
                }
                _linkSubscription?.cancel();
              }
            },
          );
        } else {
          completer.complete(
              left('status: $status  -   خطایی در شروع پرداخت پیش آمده است'));
        }
      },
    );
    return completer.future;
  }

  @override
  Future<bool> verifyPaymentRequest() async {
    Completer<bool> completer = Completer<bool>();

    ZarinPal().verificationPayment(
      _status!,
      _authority!,
      paymentRequest,
      (isPaymentSuccess, refID, paymentRequest) {
        completer.complete(isPaymentSuccess);
      },
    );

    return completer.future;
  }
}

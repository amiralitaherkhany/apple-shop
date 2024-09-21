import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:apple_shop/util/extensions/string_extensions.dart';
import 'package:apple_shop/util/url_handler.dart';
import 'package:flutter/material.dart';
import 'package:zarinpal/zarinpal.dart';

abstract class PaymentHandler {
  Future<void> initPaymentRequest(int price);
  Future<void> sendPaymentRequest();
  Future<void> verifyPaymentRequest();
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
  Future<void> sendPaymentRequest() async {
    ZarinPal().startPayment(
      paymentRequest,
      (status, paymentGatewayUri) {
        if (status == 100) {
          urlHandler.openUrl(paymentGatewayUri!);
          _linkSubscription = appLinks.uriLinkStream.listen(
            (uri) {
              //expertflutter://shop?Authority=132324323423443421212121212121212121&Status=OK
              print('app opened');
              if (uri.toString().contains('Authority')) {
                _authority = uri.toString().extractValueFromQuery('Authority');
                _status = uri.toString().extractValueFromQuery('Status');
                print(_authority);
                print(_status);
                verifyPaymentRequest();
                _linkSubscription?.cancel();
              }
            },
          );
        } else {
          print(status.toString());
        }
      },
    );
  }

  @override
  Future<void> verifyPaymentRequest() async {
    ZarinPal().verificationPayment(
      _status!,
      _authority!,
      paymentRequest,
      (isPaymentSuccess, refID, paymentRequest) {
        if (isPaymentSuccess) {
          debugPrint(refID);
        } else {
          debugPrint('payment failed');
        }
      },
    );
  }
}

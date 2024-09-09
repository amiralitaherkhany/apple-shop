import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:apple_shop/util/extensions/string_extensions.dart';
import 'package:apple_shop/util/url_handler.dart';
import 'package:flutter/material.dart';
import 'package:zarinpal/zarinpal.dart';

abstract class PaymentHandler {
  Future<void> initPaymentRequest();
  Future<void> sendPaymentRequest();
  Future<void> verifyPaymentRequest();
}

class ZarinpalPaymentHandler implements PaymentHandler {
  final PaymentRequest _paymentRequest = PaymentRequest();
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;
  String? _authority;
  String? _status;
  UrlHandler urlHandler = UrlLauncher();
  @override
  Future<void> initPaymentRequest() async {
    _paymentRequest.setIsSandBox(true);
    _paymentRequest.setAmount(105600);
    _paymentRequest.setDescription('this is a test description');
    _paymentRequest.setCallbackURL('expertflutter://shop');
    _paymentRequest.setMerchantID('XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX');
  }

  @override
  Future<void> sendPaymentRequest() async {
    ZarinPal().startPayment(
      _paymentRequest,
      (status, paymentGatewayUri) {
        if (status == 100) {
          urlHandler.openUrl(paymentGatewayUri!);
          debugPrint(Uri.parse(paymentGatewayUri).toString());
        }
      },
    );

    _linkSubscription = _appLinks.uriLinkStream.listen(
      (uri) {
        //expertflutter://shop?Authority=132324323423443421212121212121212121&Status=OK
        debugPrint('onAppLink: $uri');
        if (uri.toString().toLowerCase().contains('authority')) {
          _authority = uri.toString().extractValueFromQuery('Authority');
          _status = uri.toString().extractValueFromQuery('Status');
          debugPrint(_authority);
          debugPrint(_status);
          verifyPaymentRequest();
          _linkSubscription?.cancel();
        }
      },
    );
  }

  @override
  Future<void> verifyPaymentRequest() async {
    ZarinPal().verificationPayment(
      _status!,
      _authority!,
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
}

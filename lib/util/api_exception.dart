import 'package:dio/dio.dart';

class ApiException implements Exception {
  ApiException(this.code, this.message, {this.response}) {
    if (code == 400 && message == 'Failed to authenticate.') {
      message = 'نام کاربری یا رمز عبور اشتباه است';
    }
    if (message == 'Failed to create record.' &&
        response?.data['data']['username'] != null &&
        response?.data['data']['username']['message'] ==
            'The username is invalid or already in use.') {
      message = 'نام کاربری نامعتبر است یا قبلا گرفته شده است';
    }
    if (message == 'Failed to create record.' &&
        response?.data['data']['passwordConfirm'] != null &&
        response?.data['data']['passwordConfirm']['message'] ==
            'Values don\'t match.') {
      message = 'تکرار رمز عبور اشتباه است';
    }

    if (message == 'unknown error' || message == null) {
      message = 'ارتباط با سرور برقرار نشد';
    }
  }
  int? code;
  String? message;
  Response<dynamic>? response;
}

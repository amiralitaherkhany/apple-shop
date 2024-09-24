part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent {}

final class PaymentInitEvent extends PaymentEvent {}

final class PaymentRequestEvent extends PaymentEvent {}

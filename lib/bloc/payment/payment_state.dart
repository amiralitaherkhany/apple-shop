part of 'payment_bloc.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentResponse extends PaymentState {
  final Either<String, bool> response;
  PaymentResponse({required this.response});
}

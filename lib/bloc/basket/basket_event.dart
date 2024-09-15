part of 'basket_bloc.dart';

@immutable
sealed class BasketEvent {}

final class BasketFetchFromHive extends BasketEvent {}

final class BasketPaymentInit extends BasketEvent {}

final class BasketPaymentRequest extends BasketEvent {}

final class BasketRemoveProduct extends BasketEvent {
  final int index;

  BasketRemoveProduct({required this.index});
}

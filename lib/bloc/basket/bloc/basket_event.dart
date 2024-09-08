part of 'basket_bloc.dart';

@immutable
sealed class BasketEvent {}

final class BasketFetchFromHive extends BasketEvent {}

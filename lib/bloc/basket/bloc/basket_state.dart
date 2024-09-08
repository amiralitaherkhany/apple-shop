part of 'basket_bloc.dart';

@immutable
sealed class BasketState {}

final class BasketInitial extends BasketState {}

final class BasketDataFetched extends BasketState {
  final Either<String, List<BasketItem>> basketItems;
  final int finalPrice;
  BasketDataFetched({required this.basketItems, required this.finalPrice});
}

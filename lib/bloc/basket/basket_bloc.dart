import 'package:apple_shop/data/repository/basket_repository.dart';
import 'package:apple_shop/models/card_item.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IBasketRepository repository;
  BasketBloc({
    required this.repository,
  }) : super(BasketInitial()) {
    on<BasketFetchFromHive>((event, emit) async {
      var basketItems = await repository.getAllBasketItems();
      var finalPrice = await repository.getBasketFinalPrice();
      emit(BasketDataFetched(basketItems: basketItems, finalPrice: finalPrice));
    });

    on<BasketRemoveProduct>(
      (event, emit) async {
        await repository.removeBasketItem(event.index);
        add(BasketFetchFromHive());
      },
    );
  }
}

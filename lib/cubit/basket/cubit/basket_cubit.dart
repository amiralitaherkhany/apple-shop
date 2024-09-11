import 'package:apple_shop/data/repository/basket_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasketCubit extends Cubit<int> {
  IBasketRepository basketRepository;
  static int basketItemCount = 0;
  BasketCubit({required this.basketRepository}) : super(basketItemCount);
  void updateBasketItems() async {
    basketItemCount = await basketRepository.getBasketItemCount();
    emit(basketItemCount);
  }
}

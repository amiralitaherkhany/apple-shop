import 'package:flutter_bloc/flutter_bloc.dart';

class ScrollCubit extends Cubit<bool> {
  static bool isVisible = true;
  ScrollCubit() : super(isVisible);
  void show() {
    isVisible = true;
    emit(isVisible);
  }

  void hide() {
    isVisible = false;
    emit(isVisible);
  }
}

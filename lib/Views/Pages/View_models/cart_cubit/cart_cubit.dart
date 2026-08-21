import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'cart_state.dart';

class cartcubit extends Cubit<CartState> {
  cartcubit() : super(CartInitial());

  int quantity = 1;

  void getCartItems() {
    emit(CartLoading());
    emit(CartLoaded(dummyCart));
  }

  void incrementCounter(String productId, [int? initialValue]) {
    if (initialValue != null) {
      quantity = initialValue;
    }
    quantity++;

    emit(QuantityCounterLoaded(value: quantity));
  }

  void decrementCounter(String productId, [int? initialValue]) {
    if (quantity <= 1) {
      return;
    }

    if (initialValue != null) {
      quantity = initialValue;
    }
    quantity--;

    emit(QuantityCounterLoaded(value: quantity));
  }
}

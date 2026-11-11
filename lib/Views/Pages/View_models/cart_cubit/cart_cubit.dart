import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final Map<String, int> quantities = {};

  //-----------------GET CART ITEMS-----------------//
  void getCartItems() {
    debugPrint('GET CART LENGTH: ${dummyCart.length}');

    emit(CartLoading());

    for (final item in dummyCart) {
      quantities[item.product.id] = item.quantity;
    }

    emit(CartLoaded(dummyCart, _subtotal));
  }

  //-----------------INCREMENT-----------------//
  void incrementCounter(String productId) {
    final currentQuantity = quantities[productId] ?? 1;

    final newQuantity = currentQuantity + 1;

    quantities[productId] = newQuantity;

    final index = dummyCart.indexWhere((item) => item.product.id == productId);
    dummyCart[index] = dummyCart[index].copyWith(quantity: newQuantity);

    emit(QuantityCounterLoaded(value: newQuantity, productId: productId));
    emit(SubtotalUpdated(subtotal: _subtotal));
  }

  double get _subtotal => dummyCart.fold<double>(
    0,
    (previousValue, item) =>
        previousValue + (item.product.price * item.quantity),
  );

  //-----------------DECREMENT-----------------//
  void decrementCounter(String productId) {
    final currentQuantity = quantities[productId] ?? 1;

    if (currentQuantity <= 1) {
      return;
    }

    final newQuantity = currentQuantity - 1;

    quantities[productId] = newQuantity;

    final index = dummyCart.indexWhere((item) => item.product.id == productId);
    dummyCart[index] = dummyCart[index].copyWith(quantity: newQuantity);

    emit(QuantityCounterLoaded(value: newQuantity, productId: productId));
    emit(SubtotalUpdated(subtotal: _subtotal));
  }
}

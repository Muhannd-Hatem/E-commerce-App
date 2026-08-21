part of 'cart_cubit.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<AddToCartModel> cartItems;

  CartLoaded(this.cartItems);
}

final class CartError extends CartState {
  final String message;

  CartError(this.message);
}

final class QuantityCounterLoaded extends CartState {
  final int value;

  QuantityCounterLoaded({required this.value});
}

part of 'payment_methods_cubit.dart';

sealed class PaymentMethodsState {}

final class PaymentMethodsCubitInitial extends PaymentMethodsState {}

final class AddNewCartLoading extends PaymentMethodsState {}

final class AddNewCartSuccess extends PaymentMethodsState {}

final class AddNewCartFailure extends PaymentMethodsState {
  final String message;
  AddNewCartFailure({required this.message});
}

final class FetchingPaymentMethods extends PaymentMethodsState {}

final class FetchedPaymentMethods extends PaymentMethodsState {
  final List<PaymentCartModel> dummyPaymentCarts;
  FetchedPaymentMethods({required this.dummyPaymentCarts});
}

final class FetchPaymentMethodsFailure extends PaymentMethodsState {
  final String message;
  FetchPaymentMethodsFailure({required this.message});
}

final class PaymentMethodChosen extends PaymentMethodsState {
  final PaymentCartModel chosenPayment;
  PaymentMethodChosen(this.chosenPayment);
}

final class ConfirmPaymentLoading extends PaymentMethodsState {}

final class ConfirmPaymentSuccess extends PaymentMethodsState {}

final class ConfirmPaymentFailure extends PaymentMethodsState {
  final String message;
  ConfirmPaymentFailure({required this.message});
}

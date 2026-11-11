import 'package:ecommerce_app/models/payment_cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_methods_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit() : super(PaymentMethodsCubitInitial());

  String selectedPaymentId = dummyPaymentCarts.first.id;

  void addNewCart(
    String cardNumber,
    String cardHolderName,
    String expiryDate,
    String cvv,
  ) {
    emit(AddNewCartLoading());
    final newCart = PaymentCartModel(
      id: DateTime.now().toIso8601String(),
      cardNumber: cardNumber,
      cardHolderName: cardHolderName,
      expiryDate: expiryDate,
      cvv: cvv,
    );
    Future.delayed(Duration(seconds: 2), () {
      dummyPaymentCarts.add(newCart);
      // emit(AddNewCartSuccess());
    });
  }

  void fetchPaymentMethods() {
    emit(FetchingPaymentMethods());

    Future.delayed(const Duration(seconds: 1), () {
      if (isClosed) return;

      if (dummyPaymentCarts.isNotEmpty) {
        final chosenPaymentMethod = dummyPaymentCarts.firstWhere(
          (paymentCards) => paymentCards.isChosen == true,
          orElse: () => dummyPaymentCarts.first,
        );
        emit(FetchedPaymentMethods(dummyPaymentCarts: dummyPaymentCarts));
        emit(PaymentMethodChosen(chosenPaymentMethod));
      } else {
        emit(FetchPaymentMethodsFailure(message: 'No payment methods found'));
      }
    });
  }

  void chosenPaymentMethod(String id) {
    var chosenPaymentMethod = dummyPaymentCarts.firstWhere(
      (element) => element.id == id,
    );

    var previousPaymentMethod = dummyPaymentCarts.firstWhere(
      (paymentCard) => paymentCard.isChosen == true,
      orElse: () => dummyPaymentCarts.first,
    );

    previousPaymentMethod = previousPaymentMethod.copyWith(isChosen: false);

    chosenPaymentMethod = chosenPaymentMethod.copyWith(isChosen: true);
    emit(PaymentMethodChosen(chosenPaymentMethod));
  }

  void changePaymentMethod(String id) {
    selectedPaymentId = id;
    var tempchosenPaymentMethod = dummyPaymentCarts.firstWhere(
      (element) => element.id == selectedPaymentId,
    );
    emit(PaymentMethodChosen(tempchosenPaymentMethod));
  }

  void confirmPaymentMethod() {
    emit(ConfirmPaymentLoading());
    Future.delayed(Duration(seconds: 1), () {
      var chosenPaymentMethod = dummyPaymentCarts.firstWhere(
        (paymentCard) => paymentCard.id == selectedPaymentId,
      );

      var previousPaymentMethod = dummyPaymentCarts.firstWhere(
        (paymentCard) => paymentCard.isChosen == true,
        orElse: () => dummyPaymentCarts.first,
      );

      previousPaymentMethod = previousPaymentMethod.copyWith(isChosen: false);
      chosenPaymentMethod = chosenPaymentMethod.copyWith(isChosen: true);
      final previousIndex = dummyPaymentCarts.indexWhere(
        (paymentCart) => paymentCart.id == previousPaymentMethod.id,
      );
      final chosenIndex = dummyPaymentCarts.indexWhere(
        (paymentCart) => paymentCart.id == chosenPaymentMethod.id,
      );
      dummyPaymentCarts[previousIndex] = previousPaymentMethod;
      dummyPaymentCarts[chosenIndex] = chosenPaymentMethod;

      emit(ConfirmPaymentSuccess());
    });
  }
}

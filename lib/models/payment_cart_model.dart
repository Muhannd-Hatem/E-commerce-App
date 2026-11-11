class PaymentCartModel {
  final String id;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvv;
  final bool isChosen;

  PaymentCartModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv,
    this.isChosen = false,
  });

  PaymentCartModel copyWith({
    String? id,
    String? cardNumber,
    String? cardHolderName,
    String? expiryDate,
    String? cvv,
    bool? isChosen,
  }) {
    return PaymentCartModel(
      id: id ?? this.id,
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
      isChosen: isChosen ?? this.isChosen,
    );
  }
}

List<PaymentCartModel> dummyPaymentCarts = [
  PaymentCartModel(
    id: '1',
    cardNumber: '**** **** **** 0043',
    cardHolderName: 'John Doe',
    expiryDate: '01/22',
    cvv: '908',
  ),

  PaymentCartModel(
    id: '2',
    cardNumber: '**** **** **** 4567',
    cardHolderName: 'Muhannd Hatem',
    expiryDate: '01/24',
    cvv: '567',
  ),

  PaymentCartModel(
    id: '3',
    cardNumber: '**** **** **** 4564',
    cardHolderName: 'Tim Cook',
    expiryDate: '01/27',
    cvv: '243',
  ),
];

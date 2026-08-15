class AddToCartModel {
  final String productId;
  final int quantity;
  final String size;

  AddToCartModel({
    required this.productId,
    required this.quantity,
    required this.size,
  });

  AddToCartModel copyWith({String? productId, int? quantity, String? size}) {
    return AddToCartModel(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
    );
  }
}

List<AddToCartModel> dummyCart = [];

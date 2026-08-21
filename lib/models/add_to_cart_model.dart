import 'package:ecommerce_app/models/product_item_model.dart';

class AddToCartModel {
  final String id;
  final ProductItemModel product;
  final int quantity;
  final String size;

  AddToCartModel({
    required this.id,
    required this.product,
    required this.quantity,
    required this.size,
  });

  AddToCartModel copyWith({
    String? id,
    ProductItemModel? product,
    int? quantity,
    String? size,
  }) {
    return AddToCartModel(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
    );
  }
}

List<AddToCartModel> dummyCart = [];

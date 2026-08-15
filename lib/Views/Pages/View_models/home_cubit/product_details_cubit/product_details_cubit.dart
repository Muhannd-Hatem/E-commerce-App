import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  late ProductItemModel selectedProduct;

  ProductSize? selectedSize;

  int quantity = 1;

  // ---------------- Product Details ----------------

  void getProductDetails(String id) {
    emit(ProductDetailsLoading());

    Future.delayed(const Duration(seconds: 1), () {
      selectedProduct = products.firstWhere((product) => product.id == id);

      // Reset product-specific values
      quantity = 1;
      selectedSize = null;

      emit(ProductDetailsLoaded(product: selectedProduct));
    });
  }

  // ---------------- Size ----------------

  void selectSize(ProductSize size) {
    selectedSize = size;

    emit(SelectedSize(size: size));
  }

  // ---------------- Counter ----------------

  void incrementCounter() {
    quantity++;

    emit(QuantityCounterLoaded(value: quantity));
  }

  void decrementCounter() {
    if (quantity <= 1) {
      return;
    }

    quantity--;

    emit(QuantityCounterLoaded(value: quantity));
  }

  // ---------------- Add To Cart ----------------

  void addToCart(String productId) {
    // Size validation
    if (selectedSize == null) {
      emit(ProductDetailsError(message: 'Please select a size first'));

      return;
    }

    // Start loading
    emit(ProductAddingToCart());

    final cartItem = AddToCartModel(
      productId: productId,
      quantity: quantity,
      size: selectedSize!.name,
    );

    Future.delayed(const Duration(seconds: 1), () {
      dummyCart.add(cartItem);

      emit(ProductAddedToCart(productId: productId));
    });
  }
}

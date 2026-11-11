import 'package:ecommerce_app/Views/Pages/utils/api_path.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/firestore_servises.dart';

abstract class ProductDetailsServices {
  Future<ProductItemModel> fetchProductDetails(String productId);
}

class ProductDetailsServicesImpl implements ProductDetailsServices {
  final firestoreServices = FirestoreServices.instance;
  @override
  Future<ProductItemModel> fetchProductDetails(String productId) async {
    final reslut = await firestoreServices.getDocument<ProductItemModel>(
      path: ApiPath.product(productId),
      builder: (data, documentID) => ProductItemModel.fromMap(data, documentID),
    );
    return reslut;
  }
}

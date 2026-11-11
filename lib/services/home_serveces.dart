import 'package:ecommerce_app/Views/Pages/utils/api_path.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/firestore_servises.dart';

abstract class HomeServeces {
  Future<List<ProductItemModel>> fetchProducts();
}

class HomeServecesImpl implements HomeServeces {
  final firestoreServices = FirestoreServices.instance;

  @override
  Future<List<ProductItemModel>> fetchProducts() async {
    final result = await firestoreServices.getCollection<ProductItemModel>(
      path: ApiPath.products(),
      builder: (data, documentId) => ProductItemModel.fromMap(data, documentId),
    );
    return result;
  }
}

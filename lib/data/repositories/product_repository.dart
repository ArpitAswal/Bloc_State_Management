import 'dart:convert';

import '../../models/product_model.dart';
import '../providers/product_data_provider.dart';

// --- Repository --- (Provides data to the Cubit)
class ProductRepository {
  final ProductDataProvider productDataProvider;

  ProductRepository(this.productDataProvider);

  Future<List<ProductItem>> getProductItemList() async {
    try {
      final response = await productDataProvider.getAllProducts();

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body) as List;
        return jsonList.map((json) => ProductItem.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch products: ${response.statusCode}');
      }
    } catch (e) {
      throw e.toString();
    }
  }
}

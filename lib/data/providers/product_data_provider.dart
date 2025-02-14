import 'package:http/http.dart' as http;

// --- Data Provider --- (Handles API requests)
class ProductDataProvider {
  Future<http.Response> getAllProducts() async {
    try {
      final res = await http.get(
        Uri.parse(
          'https://fakestoreapi.com/products',
        ),
      );
      return res;
    } catch (e) {
      throw e.toString();
    }
  }
}

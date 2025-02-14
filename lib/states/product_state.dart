import '../models/product_model.dart';

// --- States --- (Define UI states)
sealed class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final List<ProductItem> products;

  ProductSuccess(this.products);
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}

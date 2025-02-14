import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repositories/product_repository.dart';
import '../states/product_state.dart';

// --- Cubit --- (Manages state and interacts with the repository)
class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repo;
  ProductCubit(this.repo) : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    try {
      final response = await repo.getProductItemList();
      emit(ProductSuccess(response));
    } catch (e) {
      emit(ProductError('An error occurred: $e'));
    }
  }
}

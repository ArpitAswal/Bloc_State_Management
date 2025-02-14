import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/cart_model.dart';

// --- Cart Cubit --- (Manages the list of cart items)
class CartCubit extends Cubit<List<CartItem>> {
  CartCubit() : super([]); // Start with an empty list

  void addItem(String name) {
    final newItem = CartItem(name: name); // Create a new CartItem
    emit([
      ...state,
      newItem
    ]); // Add the new item to the list. The spread operator(...) is like "unwrapping" the current list and adding the new item to it.  This creates a *new* list, which is important for Cubit/Bloc to work correctly.
  }

  void toggleFavorite(int index) {
    final updatedList = List<CartItem>.from(
        state); // Create a *new* list that is a copy of the current list.  This is important!
    updatedList[index] = updatedList[index].copyWith(
      isFavorite: !updatedList[index]
          .isFavorite, // Change the isFavorite status of the item at the given index
    ); // Use copyWith to create a *new* CartItem with the updated isFavorite status.
    emit(updatedList); // Tell everyone (the UI) that the list has changed.
  }
}

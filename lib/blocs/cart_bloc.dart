// Cart Bloc
import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/cart_event.dart';
import '../models/cart_model.dart';
import '../states/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    // initial value when the cart bloc create
    on<AddItemEvent>(
        _onAddItem); // When someone wants to add an item, call _onAddItem
    on<ToggleFavoriteEvent>(
        _onToggleFavorite); // When someone wants to toggle favorite, call _onToggleFavorite
  }

  void _onAddItem(AddItemEvent event, Emitter<CartState> emit) {
    final newItem = CartItem(name: event.name); // Create a new CartItem
    final currentState = state; // Get the current state of the cart
    List<CartItem> updatedList = []; // Create a new empty list

    if (currentState is CartUpdated) {
      // Check if the current state is CartUpdated.  "is" is like asking "is this a...?"
      updatedList = List.from(currentState
          .items); // If it is, copy the items from the current state to the new list
    }

    updatedList.add(newItem); // Add the new item to the new list
    emit(CartUpdated(
        items:
            updatedList)); // Tell everyone that the cart has been updated with the new list
  }

  void _onToggleFavorite(ToggleFavoriteEvent event, Emitter<CartState> emit) {
    final currentState = state;
    if (currentState is CartUpdated) {
      // Check if the current state is CartUpdated
      final updatedList = List<CartItem>.from(
          currentState.items); // Create a new copy of the list
      updatedList[event.index] = updatedList[event.index].copyWith(
        isFavorite: !updatedList[event.index]
            .isFavorite, // Toggle the favorite status using copyWith
      );
      emit(CartUpdated(
          items: updatedList)); // Tell everyone the cart has been updated
    }
  }
}

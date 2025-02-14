// Define states
import '../models/cart_model.dart';

sealed class CartState {}

class CartInitial extends CartState {} // The cart is empty at the beginning

class CartUpdated extends CartState {
  final List<CartItem> items;
  CartUpdated({required this.items});
}

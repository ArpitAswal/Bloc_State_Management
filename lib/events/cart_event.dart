// Define events (Things that can happen to the cart)
sealed class CartEvent {}

class AddItemEvent extends CartEvent {
  final String name;
  AddItemEvent({required this.name});
}

class ToggleFavoriteEvent extends CartEvent {
  final int index;
  ToggleFavoriteEvent({required this.index});
}
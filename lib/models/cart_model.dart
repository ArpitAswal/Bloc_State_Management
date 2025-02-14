
// --- Cart Item Model ---
class CartItem {
  final String name; // The name of the item (like "Apple" or "Shirt")
  bool isFavorite; // Whether the user has marked this item as a favorite

  CartItem({required this.name, this.isFavorite = true});

  /* copyWith is a special method that helps us create a *new* CartItem
     that is a copy of an *existing* CartItem, but with some changes.
     It's like making a photocopy and then writing something different on it. */
  CartItem copyWith({String? name, bool? isFavorite}) {
    return CartItem(
      name: name ?? this.name, // If a new name is given, use it; otherwise, keep the old name
      isFavorite: isFavorite ?? this.isFavorite, // Same for isFavorite
    );
  }
}
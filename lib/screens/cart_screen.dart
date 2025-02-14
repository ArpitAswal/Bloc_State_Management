// --- Cart Screen (using Cubit) ---
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cart_bloc.dart';
import '../cubits/cart_cubit.dart';
import '../events/cart_event.dart';
import '../models/cart_model.dart';
import '../states/cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Cart Cubit & Bloc')),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: BlocBuilder<CartCubit, List<CartItem>>(
              // Listen for changes in the Cubit's state
              builder: (context, state) {
                if (state.isEmpty) {
                  return const Center(
                      child: Text("Cart is Empty",
                          style: TextStyle(color: Colors.blue)));
                } else {
                  return ListView.builder(
                    // Build a list of cart items
                    itemCount: state.length, // The number of items in the cart
                    itemBuilder: (context, index) {
                      final item =
                          state[index]; // Get the item at the current index
                      return ListTile(
                        // Display each item in a ListTile
                        title: Text(item.name,
                            style: const TextStyle(color: Colors.blue)),
                        trailing: IconButton(
                          // A button to toggle favorite status
                          icon: Icon(
                            item.isFavorite
                                ? Icons.favorite
                                : Icons
                                    .favorite_border, // Show the correct icon
                            color: Colors.red,
                          ),
                          onPressed: () {
                            context.read<CartCubit>().toggleFavorite(
                                index); // Toggle favorite using Cubit
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 26.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      final random =
                          Random(); // Create a random number generator
                      final words = [
                        'Apple',
                        'Banana',
                        'Orange',
                        'Grape',
                        'Mango'
                      ]; // A list of words
                      final randomWord = words[
                          random.nextInt(words.length)]; // Pick a random word
                      context.read<CartCubit>().addItem(
                          randomWord); // Add the random word to the cart using the Cubit
                    },
                    child: const Text("Add Cart Cubit")),
                GestureDetector(
                    onTap: () {
                      final random = Random();
                      final words = [
                        'Apple',
                        'Banana',
                        'Orange',
                        'Grape',
                        'Mango'
                      ];
                      final randomWord = words[random.nextInt(words.length)];
                      context.read<CartBloc>().add(AddItemEvent(
                          name:
                              randomWord)); // Add item using Bloc.  context.read is used because we are *dispatching* an event, not *reacting* to a state change.
                    },
                    child: const Text("Add Cart Bloc")),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<CartBloc, CartState>(
              // Listen for changes in the Bloc's state
              builder: (context, state) {
                if (state is CartInitial) {
                  // If the cart is empty
                  return const Center(
                      child: Text("Cart is Empty",
                          style: const TextStyle(color: Colors.green)));
                } else if (state is CartUpdated) {
                  // If the cart has been updated
                  return ListView.builder(
                    // Build a list of cart items
                    itemCount:
                        state.items.length, // The number of items in the cart
                    itemBuilder: (context, index) {
                      final item = state
                          .items[index]; // Get the item at the current index
                      return ListTile(
                        // Display each item in a ListTile
                        title: Text(item.name,
                            style: const TextStyle(color: Colors.green)),
                        trailing: IconButton(
                          // A button to toggle favorite status
                          icon: Icon(
                            item.isFavorite
                                ? Icons.favorite
                                : Icons
                                    .favorite_border, // Show the correct icon
                            color: Colors.red,
                          ),
                          onPressed: () {
                            context.read<CartBloc>().add(ToggleFavoriteEvent(
                                index: index)); // Toggle favorite using Bloc
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text("Unknown State"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

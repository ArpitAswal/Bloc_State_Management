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
      appBar: AppBar(title: const Text('Cart Cubit & Bloc')),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            onPressed: () {
              final random = Random(); // Create a random number generator
              final words = [
                'Apple',
                'Banana',
                'Orange',
                'Grape',
                'Mango'
              ]; // A list of words
              final randomWord =
                  words[random.nextInt(words.length)]; // Pick a random word
              context.read<CartCubit>().addItem(
                  randomWord); // Add the random word to the cart using the Cubit
            },
            tooltip: "Cubit Cart",
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              final random = Random();
              final words = ['Apple', 'Banana', 'Orange', 'Grape', 'Mango'];
              final randomWord = words[random.nextInt(words.length)];
              context.read<CartBloc>().add(AddItemEvent(
                  name:
                      randomWord)); // Add item using Bloc.  context.read is used because we are *dispatching* an event, not *reacting* to a state change.
            },
            tooltip: "Bloc Cart",
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: BlocBuilder<CartCubit, List<CartItem>>(
                  // Listen for changes in the Cubit's state
                  builder: (context, state) {
                    return ListView.builder(
                      // Build a list of cart items
                      itemCount:
                          state.length, // The number of items in the cart
                      itemBuilder: (context, index) {
                        final item =
                            state[index]; // Get the item at the current index
                        return ListTile(
                          // Display each item in a ListTile
                          title: Text(item.name),
                          trailing: IconButton(
                            // A button to toggle favorite status
                            icon: Icon(
                              item.isFavorite
                                  ? Icons.favorite
                                  : Icons
                                      .favorite_border, // Show the correct icon
                            ),
                            onPressed: () {
                              context.read<CartCubit>().toggleFavorite(
                                  index); // Toggle favorite using Cubit
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: BlocBuilder<CartBloc, CartState>(
                  // Listen for changes in the Bloc's state
                  builder: (context, state) {
                    if (state is CartInitial) {
                      // If the cart is empty
                      return const Center(child: Text("Cart is Empty"));
                    } else if (state is CartUpdated) {
                      // If the cart has been updated
                      return ListView.builder(
                        // Build a list of cart items
                        itemCount: state
                            .items.length, // The number of items in the cart
                        itemBuilder: (context, index) {
                          final item = state.items[
                              index]; // Get the item at the current index
                          return ListTile(
                            // Display each item in a ListTile
                            title: Text(item.name),
                            trailing: IconButton(
                              // A button to toggle favorite status
                              icon: Icon(
                                item.isFavorite
                                    ? Icons.favorite
                                    : Icons
                                        .favorite_border, // Show the correct icon
                              ),
                              onPressed: () {
                                context.read<CartBloc>().add(ToggleFavoriteEvent(
                                    index:
                                        index)); // Toggle favorite using Bloc
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
            ),
          ],
        ),
      ),
    );
  }
}

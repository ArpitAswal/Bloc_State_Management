import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/product_cubit.dart';
import '../models/product_model.dart';
import '../states/product_state.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Products'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context
              .read<ProductCubit>()
              .fetchProducts(); // Fetch data on FAB press
        },
        child: const Icon(Icons.refresh),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductSuccess) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                final viewModel =
                    ProductViewModel(product: product); // Create ViewModel
                return Card(
                  child: ListTile(
                    leading: Image.network(
                      product.image,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(viewModel.formattedPrice), // Use formatted price
                        Text(viewModel.ratingText), // Use formatted rating
                      ],
                    ),
                    // Add more details as needed
                  ),
                );
              },
            );
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(
                child: Text("Unknown State")); // Handle other states if needed
          }
        },
      ),
    );
  }
}

// --- View Model --- (Prepares data for the UI)
class ProductViewModel {
  final ProductItem product;

  ProductViewModel({required this.product});

  String get formattedPrice =>
      '\$${product.price.toStringAsFixed(2)}'; // Format price
  String get ratingText =>
      '${product.rating.rate} (${product.rating.count} reviews)'; // Format rating
}

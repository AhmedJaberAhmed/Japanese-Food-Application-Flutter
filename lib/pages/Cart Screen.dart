import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/colors.dart';
import 'cubites/cart_cubit/cart_cubit.dart';
import 'cubites/cart_cubit/cart_state.dart';
import 'FoodDetailsPage.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void navigateToFoodDetails(BuildContext context, food) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailsPage(food: food),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey[300],
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Your Cart"),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return Center(
              child: Text(
                "Cart is empty",
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              final cartItem = state.items[index];
              return Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: Image.asset(cartItem.food.imagePath, width: 50, height: 50),
                  title: Text(cartItem.food.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("Qty: ${cartItem.quantity}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      context.read<CartCubit>().removeItem(cartItem.food);
                    },
                  ),
                  onTap: () => navigateToFoodDetails(context, cartItem.food),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(16),
            color: primaryColor,
            child: Text(
              "Total: \$${state.totalPrice.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}

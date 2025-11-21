import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/food.dart';
import 'FoodDetailsPage.dart';
import 'cubites/favourites_cubit/favorites_cubit.dart';
import 'cubites/favourites_cubit/favorites_state.dart';
import '../theme/colors.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  void navigateToFoodDetails(BuildContext context, Food food) {
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
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Favorites"),
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state.favorites.isEmpty) {
            return Center(
              child: Text(
                "No favorite items",
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              final food = state.favorites[index];
              return Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: Image.asset(food.imagePath, width: 50, height: 50),
                  title: Text(food.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("\$${food.price}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      context.read<FavoritesCubit>().removeFavorite(food);
                    },
                  ),
                  onTap: () => navigateToFoodDetails(context, food),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

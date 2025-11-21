import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/food.dart';
import '../pages/cubites/favourites_cubit/favorites_cubit.dart';

class FoodTile extends StatelessWidget {
  final Food food;
  final VoidCallback? onTap;

  const FoodTile({super.key, required this.food, this.onTap});

  @override
  Widget build(BuildContext context) {
    final favCubit = context.watch<FavoritesCubit>();
    final isFav = favCubit.isFavorite(food);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,

        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Image.asset(
              food.imagePath,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 5),

            Text(
              food.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 3),

            Row(
              children: [
                Text(
                  "\$${food.price}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                      fontSize: 12),
                ),
                const SizedBox(width: 5),
                Icon(Icons.star, color: Colors.yellow[800], size: 14),
                const SizedBox(width: 2),
                Text(
                  food.ratting,
                  style: TextStyle(color: Colors.grey[700], fontSize: 12),
                ),
              ],
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : Colors.grey,
                  size: 18,
                ),
                onPressed: () {
                  if (isFav) {
                    favCubit.removeFavorite(food);
                  } else {
                    favCubit.addFavorite(food);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

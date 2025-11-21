import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../db_helper.dart';
import '../../../models/food.dart';
import 'favorites_state.dart';


class FavoritesCubit extends Cubit<FavoritesState> {
  final DBHelper dbHelper;

  FavoritesCubit({required this.dbHelper}) : super(const FavoritesState()) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final raw = await dbHelper.getFavoriteItemsRaw();
    final favs = raw.map((row) {
      return Food(
        name: row['name'],
        price: row['price'],
        imagePath: row['imagePath'],
        ratting: row['ratting'],
        description: row['description'],
      );
    }).toList();

    emit(FavoritesState(favorites: favs));
  }

  Future<void> addFavorite(Food food) async {
    final already = state.favorites.where((f) => f.name == food.name).toList();
    if (already.isEmpty) {
      final newList = List<Food>.from(state.favorites)..add(food);
      emit(FavoritesState(favorites: newList));
      await dbHelper.insertFavorite(food);
    }
  }

  Future<void> removeFavorite(Food food) async {
    final newList = state.favorites.where((f) => f.name != food.name).toList();
    emit(FavoritesState(favorites: newList));
    await dbHelper.deleteFavorite(food.name);
  }

  bool isFavorite(Food food) {
    return state.favorites.any((f) => f.name == food.name);
  }
}

import 'package:equatable/equatable.dart';

import '../../../models/food.dart';

class FavoritesState extends Equatable {
  final List<Food> favorites;

  const FavoritesState({this.favorites = const []});

  FavoritesState copyWith({List<Food>? favorites}) {
    return FavoritesState(favorites: favorites ?? this.favorites);
  }

  @override
  List<Object?> get props => [favorites];
}

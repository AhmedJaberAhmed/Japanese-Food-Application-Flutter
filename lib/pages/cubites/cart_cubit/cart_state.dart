import 'package:equatable/equatable.dart';
import '../../../models/food.dart';

class CartItem {
  final Food food;
  final int quantity;

  CartItem({required this.food, required this.quantity});
}

class CartState extends Equatable {
  final List<CartItem> items;

  const CartState({this.items = const []});

  double get totalPrice {
    double total = 0;
    for (var item in items) {

      total += (double.tryParse(item.food.price) ?? 0) * item.quantity;
    }
    return total;
  }

  CartState copyWith({List<CartItem>? items}) {
    return CartState(items: items ?? this.items);
  }

  @override
  List<Object?> get props => [items];
}

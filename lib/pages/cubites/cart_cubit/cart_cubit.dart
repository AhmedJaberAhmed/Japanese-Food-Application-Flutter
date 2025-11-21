import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../db_helper.dart';
import '../../../models/food.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final DBHelper dbHelper;

  CartCubit({required this.dbHelper}) : super(const CartState()) {
    _loadCartFromDb();
  }

  Future<void> _loadCartFromDb() async {
    final raw = await dbHelper.getCartItemsRaw();
    final items = raw.map((row) {
      final food = Food(
        name: row['name'],
        price: row['price'],
        imagePath: row['imagePath'],
        ratting: row['ratting'],
        description: row['description'],
      );

      final q = row['quantity'];
      final quantity = (q is int) ? q : int.tryParse(q.toString()) ?? 1;
      return CartItem(food: food, quantity: quantity);
    }).toList();

    emit(CartState(items: items));
  }



  Future<void> addItem(Food food, int quantity, {bool replace = false}) async {
    final existing = state.items.where((i) => i.food.name == food.name).toList();
    List<CartItem> updated;

    if (existing.isNotEmpty) {
      if (replace) {

        updated = state.items.map((i) {
          if (i.food.name == food.name) {
            return CartItem(food: i.food, quantity: quantity);
          }
          return i;
        }).toList();
      } else {

        updated = state.items.map((i) {
          if (i.food.name == food.name) {
            return CartItem(food: i.food, quantity: i.quantity + quantity);
          }
          return i;
        }).toList();
      }
    } else {

      updated = List.from(state.items)..add(CartItem(food: food, quantity: quantity));
    }

    emit(CartState(items: updated));


    final item = updated.firstWhere((i) => i.food.name == food.name);
    await dbHelper.insertCartItem(food, item.quantity);
  }

  Future<void> removeItem(Food food) async {
    final updated = state.items.where((i) => i.food.name != food.name).toList();
    emit(CartState(items: updated));
    await dbHelper.deleteCartItem(food.name);
  }

  Future<void> changeQuantity(Food food, int quantity) async {
    if (quantity <= 0) {
      return removeItem(food);
    }

    final updated = state.items.map((i) {
      if (i.food.name == food.name) {
        return CartItem(food: i.food, quantity: quantity);
      }
      return i;
    }).toList();

    emit(CartState(items: updated));
    await dbHelper.insertCartItem(food, quantity);
  }

  Future<void> clearCart() async {
    for (var item in state.items) {
      await dbHelper.deleteCartItem(item.food.name);
    }
    emit(const CartState(items: []));
  }
}

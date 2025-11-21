import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/food.dart';
import '../theme/colors.dart';
import 'cubites/cart_cubit/cart_cubit.dart';
import 'cubites/favourites_cubit/favorites_cubit.dart';

class FoodDetailsPage extends StatefulWidget {
  final Food food;

  const FoodDetailsPage({super.key, required this.food});

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  int quantityCount = 1;

  @override
  void initState() {
    super.initState();

    final cartCubit = context.read<CartCubit>();
    final existing = cartCubit.state.items.where((i) => i.food.name == widget.food.name).toList();
    if (existing.isNotEmpty) {
      setState(() {
        quantityCount = existing.first.quantity;
        if (quantityCount < 1) quantityCount = 1;
      });
    }
  }

  void increment() {
    setState(() {
      quantityCount++;
    });
  }

  void decrement() {
    setState(() {
      quantityCount = quantityCount > 1 ? quantityCount - 1 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    final favCubit = context.watch<FavoritesCubit>();
    final isFavorite = favCubit.isFavorite(widget.food);


    final isInCart = cartCubit.state.items.any((i) => i.food.name == widget.food.name);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey[900],
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              if (isFavorite) {
                favCubit.removeFavorite(widget.food);
              } else {
                favCubit.addFavorite(widget.food);
              }
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ListView(
                children: [
                  Image.asset(widget.food.imagePath),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow[900]),
                      const SizedBox(width: 10),
                      Text(
                        widget.food.ratting,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.food.name,
                    style: GoogleFonts.dmSerifDisplay(fontSize: 28),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    "Description",
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.food.description,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      height: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: primaryColor,
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                Text(
                  "\$${widget.food.price}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Spacer(),


                Container(
                  decoration: BoxDecoration(
                    color: secandaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.remove, color: Colors.white),
                    onPressed: decrement,
                  ),
                ),


                SizedBox(
                  width: 40,
                  child: Center(
                    child: Text(
                      quantityCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),


                Container(
                  decoration: BoxDecoration(
                    color: secandaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: increment,
                  ),
                ),

                const SizedBox(width: 15),

                 ElevatedButton(
                  onPressed: () async {
                     await cartCubit.addItem(widget.food, quantityCount, replace: true);

                    ScaffoldMessenger.of(context).showSnackBar(
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: primaryColor,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          content: Text(
                            isInCart
                                ? '${widget.food.name} updated in cart to x$quantityCount'
                                : '${widget.food.name} added to cart x$quantityCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          action: SnackBarAction(
                            label: "OK",
                            textColor: secandaryColor,
                            onPressed: () {},
                          ),
                        ),
                      ) as SnackBar
                      ,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    isInCart ? "Update Cart" : "Add to Cart",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

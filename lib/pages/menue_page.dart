import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sushi_application/components/button.dart';
import '../components/food_tile.dart';
import '../models/food.dart';
import 'Cart Screen.dart';
import 'FoodDetailsPage.dart';
import 'favourites_page.dart';

class MenuePage extends StatefulWidget {
  const MenuePage({super.key});

  @override
  State<MenuePage> createState() => _MenuePageState();
}

class _MenuePageState extends State<MenuePage> {
  List<Food> foodMenue = [
    Food(
      name: "Salmon",
      price: "21.00",
      imagePath: "lib/sushi_images/nigiri.png",
      ratting: "4.9",
      description:
      "Japanese salmon is prized for its tender texture, rich flavor, and naturally buttery taste. Often enjoyed grilled, seared, or served raw in sushi and sashimi, it offers a delicate balance of freshness and umami.",
    ),
    Food(
      name: "Tuna",
      price: "65.00",
      imagePath: "lib/sushi_images/sushi2.png",
      ratting: "4.9",
      description:
      "Japanese tuna, known for its rich flavor and buttery texture, is a premium delicacy often used in sushi and sashimi. Its melt-in-your-mouth quality makes it highly sought after.",
    ),

    Food(
      name: "  Chicken Teriyaki",
      price: "18.50",
      imagePath: "lib/sushi_images/maki.png",
      ratting: "4.8",
      description:
      "Tender halal chicken glazed with a sweet and savory teriyaki sauce. Served grilled and caramelized, offering a perfect balance of umami and richness.",
    ),

    Food(
      name: "  Beef Gyudon",
      price: "22.00",
      imagePath: "lib/sushi_images/sushiii.png",
      ratting: "4.7",
      description:
      "A flavorful Japanese dish featuring thin slices of halal beef simmered with onions in a mildly sweet soy-based sauce, served over warm rice.",
    ),

    Food(
      name: "Ebi Tempura",
      price: "16.00",
      imagePath: "lib/sushi_images/salmon.png",
      ratting: "4.8",
      description:
      "Crispy and light Japanese-style deep-fried shrimp. Perfectly golden and served with traditional tentsuyu dipping sauce.",
    ),








    Food(
      name: "  Beef Teppanyaki",
      price: "32.00",
      imagePath: "lib/sushi_images/sushi2.png",
      ratting: "4.9",
      description:
      "Sizzling halal beef grilled on a hot teppan with vegetables. Smoky aroma, juicy texture, and rich Japanese flavor.",
    ),
  ];


  void navigateToFoodDetails(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailsPage(food: foodMenue[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Icon(Icons.menu, color: Colors.grey[900]),
          title: Text("Tokyo", style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesPage()));
              },
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.grey),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage()));
              },
            ),
          ],
        ),


      body: ListView(
        padding: EdgeInsets.zero,
        children: [

          Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 138, 60, 55),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Get 32% promo",
                      style: GoogleFonts.dmSerifDisplay(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    MyButton(text: "Redeem", onTap: () {}),
                  ],
                ),
                Image.asset(
                  "lib/sushi_images/sushi.png",
                  height: 100,
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search here..",
                fillColor: Colors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              "Food Menu",
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 10),

          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: foodMenue.length,
              itemBuilder: (context, index) {
                return FoodTile(
                  onTap: () => navigateToFoodDetails(index),
                  food: foodMenue[index],
                );
              },
            ),
          ),
          const SizedBox(height: 25),

          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'lib/sushi_images/sushi1.png',
                      height: 60,
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Salmon Eggs",
                          style: GoogleFonts.dmSerifDisplay(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '\$21.00',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    )
                  ],
                ),
                const Icon(
                  Icons.favorite_outline_rounded,
                  color: Colors.grey,
                  size: 28,
                )
              ],
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sushi_application/pages/cubites/cart_cubit/cart_cubit.dart';
import 'package:sushi_application/pages/cubites/favourites_cubit/favorites_cubit.dart';
import 'db_helper.dart';
import 'pages/intro_page.dart';
import 'pages/menue_page.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DBHelper();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CartCubit>(
          create: (_) => CartCubit(dbHelper: dbHelper),
        ),
        BlocProvider<FavoritesCubit>(
          create: (_) => FavoritesCubit(dbHelper: dbHelper),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "intropage": (context) => const IntroPage(),
        "menuepage": (context) => const MenuePage(),
      },
      home: const IntroPage(),
    );
  }
}

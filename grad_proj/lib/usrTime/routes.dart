import 'package:flutter/widgets.dart';
import '../timeelinee/screens/products/products_screen.dart';
import 'screens/cart/cart_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/init_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  InitScreen.routeName: (context) => const InitScreen(),
  HomeScreenu.routeName: (context) => const HomeScreenu(),
  ProductsScreen.routeName: (context) => const ProductsScreen(),
  CartScreen.routeName: (context) => const CartScreen(),
};

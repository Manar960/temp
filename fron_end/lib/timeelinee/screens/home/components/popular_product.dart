import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../config.dart';
import '../../../components/product_card.dart';
import '../../../models/Product.dart';
import '../../details/details_screen.dart';
import '../../products/products_screen.dart';
import 'section_title.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({Key? key});

  @override
  _PopularProductsState createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  late Future<List<Product>> futurePopularProducts;
  String companyName = '';

  @override
  void initState() {
    super.initState();
    //futurePopularProducts = _fetchPopularProducts(); // Initialize here
    getCompanyName().then((_) {
      initializeData();
    });
  }

  Future<void> initializeData() async {
    if (companyName.isNotEmpty) {
      try {
        final response = await http.get(
          Uri.parse('$getyoerprodact/companyName'),
        );

        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body)['results'];
          List<Product> products =
              data.map((product) => Product.fromJson(product)).toList();

          setState(() {
            futurePopularProducts = Future.value(products);
          });
        } else {
          throw Exception('Failed to load products');
        }
      } catch (error) {
        print('Error fetching popular products: $error');
      }
    } else {
      print('Company name is null or empty');
    }
  }

  Future<void> getCompanyName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      companyName = prefs.getString('company') ?? '';
    });
  }

  /*Future<List<Product>> _fetchPopularProducts() async {
    if (companyName.isNotEmpty) {
      try {
        final response = await http.get(
          Uri.parse('$getyoerprodact/companyName'),
        );

        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body)['results'];
          List<Product> products =
              data.map((product) => Product.fromJson(product)).toList();

          setState(() {
            futurePopularProducts = Future.value(products);
          });
        } else {
          throw Exception('Failed to load products');
        }
      } catch (error) {
        print('Error fetching popular products: $error');
      }
    } else {
      print('Company name is null or empty');
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "منتجاتنا",
            press: () {
              Navigator.pushNamed(context, ProductsScreen.routeName);
            },
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder(
            future: futurePopularProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error.toString()}');
              } else if (futurePopularProducts == null) {
                return Text('Loading...');
              } else {
                List<Product> popularProducts = snapshot.data as List<Product>;
                return Row(
                  children: [
                    ...List.generate(
                      popularProducts.length,
                      (index) {
                        if (popularProducts[index].isPopular) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: ProductCard(
                              product: popularProducts[index],
                              onPress: () => Navigator.pushNamed(
                                context,
                                DetailsScreen.routeName,
                                arguments: ProductDetailsArguments(
                                  product: popularProducts[index],
                                ),
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(width: 20),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

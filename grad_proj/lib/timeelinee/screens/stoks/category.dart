import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../../config.dart';
import '../../../usrTime/curved_navigation_bar.dart';
import '../forms/formscom.dart';
import '../home/calendar/calendar.dart';
import '../home/home_screen.dart';

class StokScreen extends StatefulWidget {
  const StokScreen({
    Key? key,
    required Size media,
  })  : _media = media,
        super(key: key);

  final Size _media;

  @override
  _StokScreenState createState() => _StokScreenState();
}

class _StokScreenState extends State<StokScreen> {
  late String companyName = '';
  late List<ProductItem> productItems = [];
  late List<ProductItem> serviceItems = [];

  @override
  void initState() {
    super.initState();
    getCompanyName().then((value) {
      getProductItems(companyName).then((items) {
        setState(() {
          productItems = items;
        });
      });

      getServicItems(companyName).then((items) {
        setState(() {
          serviceItems = items;
        });
      });
    });
  }

  Future<void> getCompanyName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      companyName = prefs.getString('company') ?? '';
    });
  }

  Future<List<ProductItem>> getProductItems(String companyName) async {
    final response = await http.get(Uri.parse('$getprodact/$companyName'));

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      print(data);
      if (data is Map<String, dynamic>) {
        return [ProductItem.fromJson(data)];
      } else {
        throw Exception('Invalid data format');
      }
    } else {
      throw Exception('Failed to load product items');
    }
  }

  Future<List<ProductItem>> getServicItems(String companyName) async {
    final response = await http.get(Uri.parse('$getservic/$companyName'));

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      print(data);
      if (data is Map<String, dynamic>) {
        return [ProductItem.fromJson(data)];
      } else {
        throw Exception('Invalid data format');
      }
    } else {
      throw Exception('Failed to load service items');
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: Material(
                elevation: 10,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: widget._media.width / 2,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _buildListTitle('المنتجات'),
                      const SizedBox(height: 10),
                      _buildDataTable(productItems),
                      _buildListTitle('خدمات'),
                      const SizedBox(height: 10),
                      _buildDataTable(serviceItems),
                    ],
                  ),
                ),
              ),
            ),
            CurvedNavigationBar(
              index: 0,
              color: const Color(0xFF063970),
              buttonBackgroundColor: const Color(0xFF063970),
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              height: 75.0,
              items: const [
                Icon(Icons.home, size: 30, color: Colors.white),
                Icon(Icons.book, size: 30, color: Colors.white),
                Icon(Icons.add, size: 30, color: Colors.white),
                Icon(Icons.factory, size: 30, color: Colors.white),
                Icon(Icons.person, size: 30, color: Colors.white),
              ],
              onTap: (index) {
                switch (index) {
                  case 0:
                    Navigator.pushNamed(context, HomeScreencom.routeName);
                    break;
                  case 1:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return CalendarPage();
                      }),
                    );
                    break;
                  case 2:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const MyButtonsScreen();
                      }),
                    );
                    break;
                  case 3: //StokScreenPage();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const MyButtonsScreen();
                      }),
                    );
                    break;
                  case 4:
                    // Navigate to the personal page
                    break;
                }
              },
            ),
          ],
        ),
      );
    } catch (e) {
      print('Error in ProductWidget build: $e');
      rethrow;
    }
  }

  Widget _buildListTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable(List<ProductItem> items) {
    if (items.isNotEmpty) {
      return Expanded(
        child: SingleChildScrollView(
          child: DataTable(
            columns: const [
              DataColumn(label: Text('الاسم')),
              DataColumn(label: Text('بار كود')),
              DataColumn(label: Text('المخزون')),
            ],
            rows: items
                .expand(
                  (item) => item.results.map(
                    (product) => DataRow(
                      cells: [
                        DataCell(Text(product['Name'] ?? 'No Name')),
                        DataCell(Text(product['parcode'] ?? 'No Barcode')),
                        DataCell(Text(product['stok']?.toString() ?? '')),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

class ProductItem {
  final List<Map<String, dynamic>> results;

  ProductItem({required this.results});

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      results: List<Map<String, dynamic>>.from(json['results'] ?? []),
    );
  }
}

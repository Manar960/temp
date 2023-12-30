import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../../config.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({
    Key? key,
    required Size media,
  })  : _media = media,
        super(key: key);

  final Size _media;

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
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
      return Material(
        elevation: 10,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: widget._media.width / 2,
          height: widget._media.height / 2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: <Widget>[
              _buildListTitle('المنتجات'),
              Expanded(child: _buildDataTable(productItems)),
              _buildListTitle('خدمات'),
              Expanded(child: _buildDataTable(serviceItems)),
            ],
          ),
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
      return SingleChildScrollView(
        child: DataTable(
          columns: const [
            DataColumn(label: Text('الاسم')),
            DataColumn(label: Text('الوصف')),
            DataColumn(label: Text('الثمن')),
            DataColumn(label: Text('بار كود')),
          ],
          rows: items
              .expand(
                (item) => item.results.map(
                  (product) => DataRow(
                    cells: [
                      DataCell(Text(product['Name'] ?? 'No Name')),
                      DataCell(Text(product['descrption'] ?? 'No Description')),
                      DataCell(
                          Text(product['price']?.toString() ?? 'No Price')),
                      DataCell(Text(product['parcode'] ?? 'No Barcode')),
                    ],
                  ),
                ),
              )
              .toList(),
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

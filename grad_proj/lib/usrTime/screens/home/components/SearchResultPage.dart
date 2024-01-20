import 'package:flutter/material.dart';

class SearchResultPage extends StatelessWidget {
  final String result;

  const SearchResultPage({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('نتائج البحث'),
      ),
      body: Center(
        child: Text(
          'النتيجة: $result',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

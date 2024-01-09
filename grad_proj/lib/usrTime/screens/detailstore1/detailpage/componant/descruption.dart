import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  const Description({super.key, required this.item});
final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
       item['descrption'] ,
        style: const TextStyle(height: 1.5),
      ),
    );
  }
}
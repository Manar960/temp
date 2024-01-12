// ignore: file_names
import 'package:flutter/material.dart';
import '../../../models/denemo.dart';

class DenemoByCityDialog extends StatelessWidget {
  final List<DenemoModel> denemoList;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  DenemoByCityDialog({required this.denemoList});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'الدينمو في المدينة المحددة',
        style: TextStyle(
          fontSize: 20,
          color: Color(0xFF063970),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (DenemoModel denemo in denemoList)
            ListTile(
              title: Text(
                denemo.name,
                style: const TextStyle(
                  color: Color(0xFF063970),
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                denemo.location.toString().split('.').last,
                style: const TextStyle(
                  color: Color(0xFF063970),
                  fontSize: 15,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

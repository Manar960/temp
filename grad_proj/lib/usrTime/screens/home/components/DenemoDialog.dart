// ignore: file_names
import 'package:flutter/material.dart';
import '../../../models/denemo.dart';
import '../../../models/denemo_service.dart';
import 'DenemoByCityDialog.dart';

// ignore: use_key_in_widget_constructors
class DenemoDialog extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _DenemoDialogState createState() => _DenemoDialogState();
}

class _DenemoDialogState extends State<DenemoDialog> {
  City _selectedCity = City.Jenin;
  List<DenemoModel> _denemoList = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'اختر المدينة',
        style: TextStyle(
          fontSize: 20,
          color: Color(0xFF063970),
        ),
      ),
      content: DropdownButton<City>(
        value: _selectedCity,
        items: City.values.map((City city) {
          return DropdownMenuItem<City>(
            value: city,
            child: Text(
              city.toString().split('.').last,
              style: const TextStyle(
                color: Color(0xFF063970),
                fontSize: 15,
              ),
            ),
          );
        }).toList(),
        onChanged: (City? value) {
          if (value != null) {
            setState(() {
              _selectedCity = value;
            });
          }
        },
        style: const TextStyle(
          color: Color(0xFF063970),
          fontSize: 15,
        ),
        icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF063970)),
        underline: Container(
          height: 2,
          color: const Color(0xFF063970),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            _denemoList =
                // ignore: await_only_futures
                await DenemoService.getDenemoListByCity(_selectedCity);
            // ignore: use_build_context_synchronously
            _showDenemoByCity(context, _denemoList);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF063970),
          ),
          child: const Text(
            'عرض الدينمو',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  void _showDenemoByCity(BuildContext context, List<DenemoModel> denemoList) {
    if (denemoList.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return DenemoByCityDialog(denemoList: denemoList);
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text(
              'لا توجد معلومات',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF063970),
              ),
            ),
            content: Text(
              'لا توجد معلومات متاحة للعرض في هذه المدينة.',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF063970),
              ),
            ),
          );
        },
      );
    }
  }
}

import 'package:flutter/material.dart';

import 'home_header.dart';

class GovernmentServicesPage extends StatefulWidget {
  @override
  _GovernmentServicesPageState createState() => _GovernmentServicesPageState();
}

class _GovernmentServicesPageState extends State<GovernmentServicesPage> {
  String _selectedPeriod = 'حديث';
  String _amount = '';
  String _nextInsureDate = '';

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _lastInsureDateController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: HomeHeader(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildDropdownButton(),
            const SizedBox(height: 16),
            _buildTextFormField(
              controller: _amountController,
              labelText: 'المبلغ',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            _buildTextFormField(
              controller: _lastInsureDateController,
              labelText: 'تاريخ آخر تأمين',
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            _buildElevatedButton(),
            const SizedBox(height: 16),
            _buildResultText('التأمين المستحق:', _amount),
            _buildResultText('تاريخ التأمين القادم:', _nextInsureDate),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownButton() {
    return DropdownButton<String>(
      value: _selectedPeriod,
      items: ['حديث', 'قديم'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(
              color: Color(0xFF063970),
              fontSize: 15,
            ),
          ),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          _selectedPeriod = value!;
        });
      },
      hint: const Text(
        'نوع الفترة',
        style: TextStyle(
          color: Color(0xFF063970),
          fontSize: 15,
        ),
      ),
      style: const TextStyle(
        color: Color(0xFF063970),
        fontSize: 15,
      ),
      icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF063970)),
      underline: Container(
        height: 2,
        color: const Color(0xFF063970),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required TextInputType keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textAlign: TextAlign.right,
      style: const TextStyle(
        fontSize: 15,
        color: Color(0xFF063970),
      ),
      decoration: InputDecoration(
        labelText: labelText,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF063970), width: 2.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _buildElevatedButton() {
    return ElevatedButton(
      onPressed: () {
        _calculateInsurance();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
      ),
      child: const Text(
        'حساب التأمين',
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildResultText(String label, String value) {
    return Text(
      '$label $value',
      style: const TextStyle(
        fontSize: 15,
        color: Color(0xFF063970),
      ),
    );
  }

  void _calculateInsurance() {
    double amount = double.tryParse(_amountController.text) ?? 0;
    DateTime lastInsureDate = DateTime.parse(_lastInsureDateController.text);

    if (_selectedPeriod == 'حديث') {
      double insuranceAmount = amount * 12;
      DateTime nextInsureDate = lastInsureDate.add(const Duration(days: 365));
      setState(() {
        _amount = insuranceAmount.toString();
        _nextInsureDate = nextInsureDate.toLocal().toString();
      });
    } else if (_selectedPeriod == 'قديم') {
      double insuranceAmount = amount * 4;
      DateTime nextInsureDate = lastInsureDate.add(const Duration(days: 120));
      setState(() {
        _amount = insuranceAmount.toString();
        _nextInsureDate = nextInsureDate.toLocal().toString();
      });
    }
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../config.dart';

class UpdateCompanyForm extends StatefulWidget {
  final String companyName;

  const UpdateCompanyForm({Key? key, required this.companyName})
      : super(key: key);

  @override
  _UpdateCompanyFormState createState() => _UpdateCompanyFormState();
}

class _UpdateCompanyFormState extends State<UpdateCompanyForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تحديث معلومات الشركة'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'اسم الشركة'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال اسم الشركة';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'البريد الإلكتروني'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال البريد الإلكتروني';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'الموقع'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال الموقع';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _aboutController,
                decoration: const InputDecoration(labelText: 'نبذة عن الشركة'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال نبذة عن الشركة';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _updateCompanyInfo();
                  }
                },
                child: const Text('تحديث'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateCompanyInfo() async {
    try {
      final response = await http.put(
        Uri.parse('$updateCompanyInfo/${widget.companyName}'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "updatedInfo": {
            "Name": _nameController.text,
            "email": _emailController.text,
            "location": _locationController.text,
          },
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم تحديث معلومات الشركة بنجاح')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل تحديث معلومات الشركة')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حدث خطأ أثناء تحديث معلومات الشركة')),
      );
    }
  }
}

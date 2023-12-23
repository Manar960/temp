import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../../config.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TypeAheadFormField(
        textFieldConfiguration: TextFieldConfiguration(
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: kSecondaryColor.withOpacity(0.1),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            border: searchOutlineInputBorder,
            focusedBorder: searchOutlineInputBorder,
            enabledBorder: searchOutlineInputBorder,
            hintText: "البحث في المنتجات",
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
          ),
        ),
        suggestionsCallback: (pattern) async {
          final productResponse = await fetchProductNames(pattern);

          return productResponse;
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(
              suggestion,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            tileColor: Colors.white,
          );
        },
        onSuggestionSelected: (suggestion) {},
      ),
    );
  }

  Future<List<String>> fetchProductNames(String pattern) async {
    // ignore: unnecessary_brace_in_string_interps
    final String apiUrl = '${searchProdacts}/$pattern';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData != null && responseData['results'] != null) {
          final List<dynamic> data = responseData['results'];
          final List<String> productNames = data.cast<String>();
          return productNames;
        } else {
          throw Exception(
              'Product names data is null or not in the expected format');
        }
      } else {
        throw Exception(
            'Failed to load product names - ${response.statusCode}');
      }
    } catch (error) {
      final serviceResponse = await fetchServiceNames(pattern);
      return serviceResponse;
    }
  }

  Future<List<String>> fetchServiceNames(String pattern) async {
    // ignore: unnecessary_brace_in_string_interps
    final String apiUrl = '${searchServices}/$pattern';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData != null && responseData['results'] != null) {
          final List<dynamic> data = responseData['results'];
          final List<String> serviceNames = data.cast<String>();
          return serviceNames;
        } else {
          throw Exception(
              'Service names data is null or not in the expected format');
        }
      } else {
        throw Exception(
            'Failed to load service names - ${response.statusCode}');
      }
    } catch (error) {
      final userResponse = await fetchUserNames(pattern);
      return userResponse;
    }
  }

  Future<List<String>> fetchUserNames(String pattern) async {
    // ignore: unnecessary_brace_in_string_interps
    final String apiUrl = '${searchUsers}/$pattern';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData != null && responseData['results'] != null) {
          final List<dynamic> data = responseData['results'];
          final List<String> userNames = data.cast<String>();
          return userNames;
        } else {
          throw Exception(
              'User names data is null or not in the expected format');
        }
      } else {
        final companyResponse = await fetchCompanyNames(pattern);
        return companyResponse;
      }
    } catch (error) {
      throw Exception('Failed to load user names - $error');
    }
  }

  Future<List<String>> fetchCompanyNames(String pattern) async {
    // ignore: unnecessary_brace_in_string_interps
    final String apiUrl = '${searchCompanies}/$pattern';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData != null && responseData['results'] != null) {
          final List<dynamic> data = responseData['results'];
          final List<String> companyNames = data.cast<String>();
          return companyNames;
        } else {
          throw Exception(
              'Company names data is null or not in the expected format');
        }
      } else {
        throw Exception(
            'Failed to load company names - ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load company names - $error');
    }
  }
}

const searchOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide.none,
);

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../../config.dart';

class FavCard extends StatefulWidget {
  const FavCard({
    Key? key,
    required this.image,
    required this.title,
    required this.bgColor,
    required this.isActive,
  }) : super(key: key);

  final String image;
  final String title;
  final Color bgColor;
  final bool isActive;

  @override
  // ignore: library_private_types_in_public_api
  _FavCardState createState() => _FavCardState();
}

class _FavCardState extends State<FavCard> {
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _isActive = widget.isActive;
  }

  Future<void> removeFromfav(String proname) async {
    final url = '$deleteFav/$proname';

    // ignore: unused_local_variable
    final response = await http.delete(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'ProName': proname,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle tap event if needed
      },
      child: Container(
        width: 154,
        padding: const EdgeInsets.all(16 / 2),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: widget.bgColor,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: Image.asset(
                widget.image,
                height: 132,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w100),
                  ),
                ),
                const SizedBox(width: 16 / 4),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isActive = !_isActive;
                    });
                    if (_isActive == false) {
                      removeFromfav(widget.title);
                    }
                  },
                  child: Icon(
                    _isActive ? Icons.favorite : Icons.favorite_border,
                    size: 25,
                    color: _isActive ? Colors.red : Colors.black,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

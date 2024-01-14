// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../config.dart';
import '../../../../dialog.dart';
import '../../../models/user.dart';
import '../../checkout/checoutpage.dart';

class CheckoutCard extends StatefulWidget {
  const CheckoutCard({
    Key? key,
  }) : super(key: key);

  @override
  _CheckoutCardState createState() => _CheckoutCardState();
}

late int itemsprice = 0;

class _CheckoutCardState extends State<CheckoutCard> {
  @override
  void initState() {
    super.initState();
  }

  Future<int> getCartItemprice(String userName) async {
    const String apiUrl = 'https://gp-back-gp.onrender.com/getprice';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'UserName': userName}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData['total'] as int;
      } else {
        throw Exception('Failed to load price');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to connect to the server');
    }
  }

  Future<void> fetchCartItemprice() async {
    try {
      final price = await getCartItemprice(username!);
      setState(() {
        itemsprice = price;
      });
    } catch (error) {
      print('Error fetching price: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchCartItemprice();
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 20,
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icon/receipt.svg"),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: "المجموع:\n",
                      children: [
                        TextSpan(
                          text: " ${itemsprice}",
                          // ignore: prefer_const_constructors
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 231, 97, 97),
                    ),
                    onPressed: () {
                      if (itemsprice == 0) {
                        showCards(context, "assets/no.json",
                            "ليس هناك اي قطعة في سلتك");
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const checkout();
                          }),
                        );
                      }
                    },
                    child: const Text(
                      "أكمل عملية الدفع",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

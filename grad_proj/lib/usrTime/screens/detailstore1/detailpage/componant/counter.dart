import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'button.dart';

class CartCounter extends StatefulWidget {
  const CartCounter({
    Key? key,
    required this.item
  }) : super(key: key);

  final Map<String, dynamic> item;
  
  @override
  _CartCounterState createState() => _CartCounterState();
}
class _CartCounterState extends State<CartCounter> {

Future<void> addToCart(String proBarCode, String userName) async {
    final url = 'https://gp-back-gp.onrender.com/addToCart';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'ProBarCode': proBarCode,
        'UserName': userName,
   
        
      }),
    );
    if (response.statusCode == 200) {
      print('Product added to cart successfully');
    } else {
      print('Failed to add product to cart');
    }
  }
  
Future<void> removeFromCart(String proBarCode, String userName) async {
    final url = 'https://gp-back-gp.onrender.com/removeFromCart/oneitem';

    final response = await http.delete(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'ProBarCode': proBarCode,
        'UserName': userName,
   
        
      }),
    );
    if (response.statusCode == 200) {
      print('Product deleted to cart successfully');
    } else {
      print('Failed to deleted product to cart');
    }
  }

  
  int numOfItems = 0;
  int total=0;
  @override
  Widget build(BuildContext context) {

    return Row(
      children: <Widget>[
        SizedBox(
          width: 40,
          height: 32,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
            ),
           onPressed: () {
            removeFromCart(widget.item['parcode'], username!);
            setState(() {
              if (numOfItems >= 1) {
                numOfItems--;
                 if(numOfItems==0){
              }
              }
            
            });
          },
            child: Icon(Icons.remove),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16 / 2),
          child: Text(
            numOfItems.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SizedBox(
          width: 40,
          height: 32,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
            ),
            onPressed: () {
            addToCart(widget.item['parcode'], username!);
              setState(() {
                numOfItems++;
              });

            },
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
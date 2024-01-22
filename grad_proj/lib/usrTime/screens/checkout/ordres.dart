import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grad_proj/constants.dart';
import 'package:grad_proj/usrTime/screens/booking/boking_screen.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import '../../../config.dart';
import '../../../login/responsive.dart';
import '../booking/boking_screen.dart';
import 'ordercards.dart';
import 'paymint.dart';

class orders extends StatefulWidget {
  const orders({Key? key, required this.paymentMethod}) : super(key: key);
  final String paymentMethod;
  @override
  _ordersState createState() => _ordersState();
}

class _ordersState extends State<orders> {
  List? item;

  @override
  void initState() {
    super.initState();

  }

  Future<void> getOrdar(String UserName) async {
    try {
      var response = await http.get(
        Uri.parse('http://localhost:4000/getOrdar/$UserName'),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setState(() {
          item = jsonResponse['orders'];
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during API request: $e');
    }
  }

  Future<void> deleteOrdar(String OrderCode, String companyName) async {
    final response = await http.delete(
      Uri.parse(deleteordar),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'OrderCode': OrderCode, 'companyName': companyName}),
    );
  }

  Future<void> removeFromCart(String CartCode) async {
    final response = await http.delete(
      Uri.parse(deleteordarCart),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'CartCode': CartCode,
      }),
    );
  }
  final List<int> codes = [158236, 859627, 789632, 123654, 852746];

  void showcards(BuildContext context) {
  int randomPower = codes[Random().nextInt(codes.length)];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: 350,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    LottieBuilder.asset(
                      "assets/car1.json",
                      width: 150,
                      height: 150,
                      fit: BoxFit.fill,
                      repeat: false,
                      animate: true,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'طلبك جاهز يرجى الاستلام في اقرب وقت'+'\n'+' يرجى اظهار الكود' +randomPower.toString()+' عند وصولك للمحل ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    getOrdar(username!);
      return Scaffold(
      appBar: AppBar(
        title: Text('طلباتك'),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsive.isDesktop(context) ? 2 : 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                  childAspectRatio: 3,
                ),
                itemCount: item?.length ?? 0,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var product = item![index];
                  return orderscards(
                    press2: () {
                      deleteOrdar(
                          item![index]['OrderCode'], item![index]['companyName']);
                      removeFromCart(item![index]['CartCode']);
                    },
                    title: item![index]['companyName'].toString(),
                    image: "assets/images/Magical_World.png",
                    price: item![index]['totalPrice'].toString(),
                    press: () {
                      if (item![index]['waydelivary'].toString() == "store") {
                        showcards(context);
                        deleteOrdar(item![index]['OrderCode'],
                            item![index]['companyName']);
                        removeFromCart(item![index]['CartCode']);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const paymentMethod1(),
                          ),
                        );
                      }
                    },
                    cardColor: index % 2 == 0
                        ? kPrimaryColor
                        : kPrimaryColor,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

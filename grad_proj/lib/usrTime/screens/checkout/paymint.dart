import 'package:flutter/material.dart';
import 'package:grad_proj/butombar.dart';
import 'package:grad_proj/usrTime/screens/checkout/waydelivary.dart';
import '../../../constants.dart';
import '../../map/map.dart';
import '../cart/cart_screen.dart';
import '../home/home_screen.dart';

import 'cards.dart';
import 'ordres.dart';

class paymentMethod1 extends StatefulWidget {
  const paymentMethod1({
    Key? key,
  }) : super(key: key);

  @override
  _paymentMethod1State createState() => _paymentMethod1State();
}

class _paymentMethod1State extends State<paymentMethod1> {
  String paymentMethod = '';
  final TextEditingController addressController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تحديد طريقة الدفع'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Center(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            paymentMethod = "creditcard";
                          });
                        },
                        child: waytodelivary(
                            icon: Icons.credit_card,
                            isactive:
                                paymentMethod == "creditcard" ? true : false,
                            title: "بطاقة الائتمان",
                            pcolor: bluecolor),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              paymentMethod = "paypal";
                            });
                          },
                          child: waytodelivary(
                            icon: Icons.paypal,
                            isactive: paymentMethod == "paypal" ? true : false,
                            title: "باي بال",
                            pcolor: bluecolor,
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (paymentMethod == "creditcard")
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 233, 240, 246),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "اضف بطاقة جديدة",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                if (paymentMethod == "creditcard")
                  const Cards(
                    isactive: false,
                    number: "124 258 457",
                    title: "visa",
                    image: "assets/visa.png",
                  ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 40,
                  width: 200,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF063970),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return orders(paymentMethod: paymentMethod);
                        }),
                      );
                    },
                    child: const Text(
                      "أكمل عملية الدفع",
                      style:
                          TextStyle(color: Colors.white, height: 1, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const HomeScreenu();
                }),
              );
              break;
            case 1:
              // Navigate to the report page
              break;
            case 2:
              // MapPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const MapPage();
                }),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const CartScreen();
                }),
              );
              break;
            case 4:
              // Navigate to the personal page
              break;
          }
        },
      ),
    );
  }
}

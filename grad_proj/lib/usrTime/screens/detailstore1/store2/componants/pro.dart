import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:grad_proj/constants.dart';
import 'package:grad_proj/login/responsive.dart';
import 'package:http/http.dart' as http;
import '../../detailpage/Detailpage.dart';
import 'procard.dart';


class productstore2 extends StatefulWidget {
  const productstore2({Key? key, required this.item}) : super(key: key);
   final Map<String, dynamic> item;

  @override
  _productstore2State createState() => _productstore2State();
}

class _productstore2State extends State<productstore2> {

    List? item;

  @override
  void initState() {
    super.initState();
    getProducts(widget.item['Name']);
  }
   Future<void> getProducts(String comname) async {
    var response = await http.get(
      Uri.parse('http://localhost:4000/getpro/$comname/SET'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        item = jsonResponse['data'];
    
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              " منتجات العناية بالسيارة",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      
      ),
      body:
           Directionality(
            textDirection: TextDirection.rtl,
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                   
                     GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsive.isDesktop(context)?3:2, 
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: Responsive.isDesktop(context)?1:0.35, 
                ),
                itemCount: item?.length ?? 0,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                return setproductcard(
                    name: item![index]["Name"],
                    image: item![index]["proimage"],
                    price: item![index]["price"],
                    desc: item![index]["descrption"],
                    bgColor: bluebasic,
                    press: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detailsproduct(item: item![index]),
                      ),
                    );
                    },
                  );
                },
                         ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
             ),
           ),
    );
   }
        
  }

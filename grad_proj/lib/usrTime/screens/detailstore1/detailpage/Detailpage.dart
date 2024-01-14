import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../constants.dart';
import '../../../../butombar.dart';
import '../../../map/map.dart';
import '../../booking/boking_screen.dart';
import '../../cart/cart_screen.dart';
import '../../home/home_screen.dart';
import 'componant/addtochart.dart';
import 'componant/button.dart';
import 'componant/descruption.dart';
import 'componant/mainfeater.dart';
import 'componant/proudctsize.dart';

class Detailsproduct extends StatefulWidget {
  const Detailsproduct({
    Key? key,
    required this.item
  }) : super(key: key);

  final Map<String, dynamic> item;
  
  @override
  _DetailsproductState createState() => _DetailsproductState();
}

class _DetailsproductState extends State<Detailsproduct> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:  bluebasic ,
      appBar: AppBar(
        backgroundColor: Colors.white ,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset("assets/icons/search.svg",color: Colors.black,),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset("assets/icons/cart.svg",color:  Colors.black),
            onPressed: () {},
          ),
          const SizedBox(width: 16 / 2)
        ],
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.3),
                    padding: EdgeInsets.only(
                      top: size.height * 0.12,
                      left: kPadding,
                      right: kPadding,
                      
                    ),
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 22),
                          BulidSize(item :widget.item),
                          const SizedBox(height: kPadding / 2),
                          Description(item :widget.item ),
                          const SizedBox(height: kPadding / 2),
                          CounterWithFavBtn(item:widget.item),
                          const SizedBox(height: 10),
                          AddToCart(item:widget.item)
                        ],
                      ),
                    ),
                  ),
                  pagedetail(item :widget.item)
                ],
              ),
            )
          ],
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const bookScreen();
                }),
              );
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
             
              break;
            }
          },
        ),

    );

    
  }
  
  

  
  }


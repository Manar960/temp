import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:grad_proj/usrTime/screens/booking/boking_screen.dart';

import '../../../../../constants.dart';
import '../../../../butombar.dart';
import '../../../map/map.dart';
import '../../cart/cart_screen.dart';
import '../../home/components/home_header.dart';
import '../../home/home_screen.dart';
import '../detailpage/componant/responsive.dart';
import '../store1/componants/ratingcard.dart';
import '../store4/components/categories.dart';
import 'componants/beforafter.dart';
import 'componants/brandcard.dart';
import 'componants/categury.dart';
import 'componants/date.dart';
import 'componants/imageslider.dart';
import 'componants/pro.dart';
import 'componants/service_section.dart';


class store2 extends StatefulWidget {
  const store2({
    Key? key,
    required this.item
  }) : super(key: key);

  final Map<String, dynamic> item;
  
  @override
  _store2State createState() => _store2State();
}

class _store2State extends State<store2> {
 

  @override
  void initState() {
    super.initState();
 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(height: 10),
            HomeHeader(),
             SizedBox(height: 10),
                  Row(
                    children: [
                     CategoryCardforstore(title: "قيمنا",icon: "assets/icons/ratesvgrepo.svg",press:(){

                      showRatingDialog(context, username!, "assets/images/userprofile.png",widget.item);

                    } ,),
                     const Spacer(),
                      Text(
                        widget.item['Name'] ,
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: deepbrowncolor,fontSize: 29),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                       InkWell(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.transparent, 
                          backgroundImage: widget.item['comimag'] != null ? AssetImage(widget.item['comimag'] ) : null,
                        ),
                      ),
                    
                
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                    child: MaterialButton(
                      height: Responsive.isDesktop(context) ? 55 : 40,
                      color: bluebasic,
                      shape: StadiumBorder(),
                      onPressed: () {

                      },
                      child: const Text(
                        "تواصل معنا",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                  ,],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                   Row(
                    children: [
                      Expanded(
                      child: MaterialButton(
                        height: Responsive.isDesktop(context) ? 55 : 40,
                        color: bluebasic,
                        shape: StadiumBorder(), 
                        onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return  DatePage(name:widget.item['Name'],image: widget.item['comimag'],user: username!,);
                          }),
                        );
                        },
                        child: const Text(
                          "احجز موعدك",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                   const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),

                  Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Center(
                     child: _buildCard(Text(
                        widget.item['location'] ,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: deepbrowncolor),
                      ),),
                   ),
                 ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: 35,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                  ),
                   Center(
                    child: Categories(item:widget.item),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child:Text(
                    "البراند",
                    textAlign: TextAlign.right,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: deepbrowncolor,fontWeight:FontWeight.bold,fontSize: 21 ,),
                        
                  ),),
                 BrandCards(),
                 const SizedBox(
                    height: 10,
                  ),
                  ServiceSection(name:widget.item['Name']),
                   const SizedBox(
                    height: 20,
                  ),
                    Center(
               child:Text(
                   "من اعمالنا",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  
                  ),
                   const SizedBox(
                    height: 10,
                  ),
                    ImageSlider(),
                  const SizedBox(
                    height: 8,
                  ),
                  Center(
               child:Text(
                    "قبل و بعد",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  
                  ),
                  const SizedBox(
                    height: 8,
                  ),
           horizontalWidgetBasedOnScreenType(context),
        
                   const SizedBox(
                    height: 10,
                  ), 
                   const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),
                //   Ratecard(press: (){
                //      Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) {
                //     return  Reviwandcommint(item: widget.item,);
                //   }),
                // );
                //   },
                //   item: widget.item,)
              
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
                    return  bookScreen();
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
               Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const CartScreen();
                        }),
                      );
                break;
            }
          },
        ),
    );
  }
   Widget _buildCard(Widget card) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.black,
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Container(
      height:  90,
      width: 500,
      child: card,
    ),
  );
}





}
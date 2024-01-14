import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:grad_proj/butombar.dart';
import 'package:grad_proj/constants.dart';
import '../../../map/map.dart';
import '../../booking/boking_screen.dart';
import '../../cart/cart_screen.dart';
import '../../home/components/home_header.dart';
import '../../home/home_screen.dart';
import '../detailpage/componant/responsive.dart';
import '../store1/componants/ratingcard.dart';
import '../store2/componants/date.dart';
import 'components/categories.dart';
import 'components/new_arrival_products.dart';
import 'components/popular_products.dart';



class store4 extends StatefulWidget {
  const store4({
    Key? key,
    required this.item
  }) : super(key: key);

  final Map<String, dynamic> item;
  
  @override
  _store4State createState() => _store4State();
}

class _store4State extends State<store4> {
 

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
                        width: 8,
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
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(child: Catforstore()),
                   const SizedBox(
                    height: 10,
                  ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: NewArrivalProducts(item:widget.item),
                   ),
                   const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: PopularProducts(),
                  ),
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
                //   },item: widget.item,)
              
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

import 'package:flutter/material.dart';
import 'package:grad_proj/usrTime/screens/booking/boking_screen.dart';

import '../../../../butombar.dart';
import '../../../../constants.dart';
import '../../../map/map.dart';
import '../../cart/cart_screen.dart';
import '../../home/components/home_header.dart';
import '../../home/home_screen.dart';
import '../../rating/Ratecard.dart';
import '../../rating/rate.dart';
import '../store4/components/categories.dart';
import 'componants/Brand.dart';
import 'componants/Categoriesviwe.dart';
import 'componants/ratingcard.dart';

class store1 extends StatefulWidget {
  const store1({Key? key, required this.item}) : super(key: key);

  final Map<String, dynamic> item;

  @override
  _store1State createState() => _store1State();
}

class _store1State extends State<store1> {
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
                CategoryCardforstore(
                  title: "قيمنا",
                  icon: "assets/icons/ratesvgrepo.svg",
                  press: () {
                    showRatingDialog(context, username!,
                        "assets/images/userprofile.png", widget.item);
                  },
                ),
                const Spacer(),
                Text(
                  widget.item['Name'],
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: deepbrowncolor, fontSize: 29),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    backgroundImage: widget.item['comimag'] != null
                        ? AssetImage(widget.item['comimag'])
                        : null,
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
                    height: 45,
                    color: bluebasic,
                    shape: StadiumBorder(),
                    onPressed: () {},
                    child: const Text(
                      "تواصل معنا",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
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
                child: _buildCard(
                  Column(
                    children: [
                      Text(
                        widget.item['about'],
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: deepbrowncolor),
                      ),
                    ],
                  ),
                ),
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
            Categoriesviwe(item: widget.item),
            const SizedBox(
              height: 10,
            ),
            Brandviwe(item: widget.item),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(
                height: 4,
              ),
            ),
            Ratecard(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return Reviwandcommint(item: widget.item);
                  }),
                );
              },
              item: widget.item,
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
                  return MapPage();
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
        height: 90,
        width: 500,
        child: card,
      ),
    );
  }
}

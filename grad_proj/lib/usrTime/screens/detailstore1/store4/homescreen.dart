import 'package:flutter/material.dart';
import 'package:grad_proj/butombar.dart';
import 'package:grad_proj/constants.dart';
import 'package:grad_proj/usrTime/screens/detailstore1/store4/components/seeall.dart';
import '../../../map/map.dart';
import '../../../profile/page/profile_page_user.dart';
import '../../booking/boking_screen.dart';
import '../../cart/cart_screen.dart';
import '../../home/components/home_header.dart';
import '../../home/home_screen.dart';
import '../../rating/Ratecard.dart';
import '../../rating/rate.dart';
import '../detailpage/componant/responsive.dart';
import '../store1/componants/ratingcard.dart';
import '../store2/componants/date.dart';
import '../store2/store2.dart';
import 'components/categories.dart';
import 'components/new_arrival_products.dart';
import 'components/popular_products.dart';

// ignore: camel_case_types
class store4 extends StatefulWidget {
  const store4({Key? key, required this.item}) : super(key: key);

  final Map<String, dynamic> item;

  @override
  // ignore: library_private_types_in_public_api
  _store4State createState() => _store4State();
}

// ignore: camel_case_types
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
            const SizedBox(height: 10),
            const HomeHeader(),
            const SizedBox(height: 10),
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
                      .displaySmall!
                      .copyWith(color: deepbrowncolor, fontSize: 29),
                ),
                const SizedBox(
                  width: 8,
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
                    height: Responsive.isDesktop(context) ? 55 : 40,
                    color: bluebasic,
                    shape: const StadiumBorder(),
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
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    height: Responsive.isDesktop(context) ? 55 : 40,
                    color: bluebasic,
                    shape: const StadiumBorder(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return DatePage(
                            name: widget.item['Name'],
                            image: widget.item['comimag'],
                            user: username!,
                          );
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
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return SeeAll(
                        item: widget.item,
                      );
                    }),
                  );
                },
                child: const title(
                    tile: "جميع السيارات المتوفرة", icon: Icons.car_rental)),
            const SizedBox(
              height: 20,
            ),
            const title(
                tile: "العلامات التجارية", icon: Icons.supervised_user_circle),
            const Directionality(
                textDirection: TextDirection.rtl,
                child: Center(child: Catforstore())),
            const SizedBox(
              height: 10,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: NewArrivalProducts(item: widget.item),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PopularProducts(item: widget.item),
              ),
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
            Ratecard(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return Reviwandcommint(
                      item: widget.item,
                    );
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const ProfilePage();
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
      child: SizedBox(
        height: 90,
        width: 500,
        child: card,
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grad_proj/usrTime/screens/booking/boking_screen.dart';
import '../../../../../constants.dart';
import '../../../../butombar.dart';
import '../../../map/map.dart';
import '../../cart/cart_screen.dart';
import '../../home/components/home_header.dart';
import '../../home/home_screen.dart';
import '../../rating/Ratecard.dart';
import '../../rating/rate.dart';
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
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class store2 extends StatefulWidget {
  const store2({Key? key, required this.item}) : super(key: key);

  final Map<String, dynamic> item;

  @override
  // ignore: library_private_types_in_public_api
  _store2State createState() => _store2State();
}

// ignore: camel_case_types
class _store2State extends State<store2> {
  @override
  void initState() {
    super.initState();
    getimages(widget.item['Name']);
  }
  List <String> blobs=[],blobs2=[];
 Future<void> getimages(String name) async {
  try {
   
    final response = await http.get(
      Uri.parse('http://localhost:4000/getimages/$name'),
      headers: {"Content-Type": "application/json"},
    
    );
if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setState(() {
                blobs = (jsonResponse['blobs'] as List<dynamic>).cast<String>();
        blobs2 = (jsonResponse['blobs2'] as List<dynamic>).cast<String>();
        });

        print(blobs);
      } else {
        // ignore: avoid_print
        print('Request failed with status: ${response.statusCode}');
      }
  } catch (error) {
    print('Error: $error');
  }
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
            Builder(builder: (context) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => productstore2(item: widget.item),
                    ),
                  );
                },
                child: const title(
                    tile: "منتجات العناية بالسيارات",
                    icon: Icons.airport_shuttle_outlined),
              );
            }),
            const SizedBox(
              height: 10,
            ),
            const title(
                tile: "العلامات التجارية المشهورة",
                icon: Icons.no_crash_rounded),
            const Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: BrandCards(),
                )),
            const SizedBox(
              height: 10,
            ),
            const title(
                tile: "الخدمات المتوفرة", icon: Icons.supervised_user_circle),
            ServiceSection(name: widget.item['Name']),
            const SizedBox(
              height: 20,
            ),
            const title(
                tile: "من اعمالنا", icon: Icons.workspace_premium_outlined),
            const SizedBox(
              height: 10,
            ),
             ImageSlider(blobs:blobs),
            const SizedBox(
              height: 8,
            ),
            const title(tile: "قبل وبعد", icon: Icons.shape_line_outlined),
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
      child: SizedBox(
        height: 90,
        width: 500,
        child: card,
      ),
    );
  }
}

class title extends StatelessWidget {
  const title({
    super.key,
    required this.tile,
    required this.icon,
  });
  final String tile;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            Text(
              tile,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: deepbrowncolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              icon,
              color: bluebasic,
              size: 40,
            )
          ],
        ),
      ),
    );
  }
}

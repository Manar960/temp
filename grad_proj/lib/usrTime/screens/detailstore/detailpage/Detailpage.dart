import 'package:flutter/material.dart';
import '../../../../constants.dart';
import '../../../map/map.dart';
import '../../booking/boking_screen.dart';
import '../../butombar.dart';
import '../../cart/cart_screen.dart';
import '../../home/components/home_header.dart';
import '../../home/home_screen.dart';
import '../store1/componants/wheels.dart';

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
            const SizedBox(height: 10),
            const HomeHeader(),
            const SizedBox(height: 10),
            Row(
              children: [
                InkWell(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    backgroundImage: widget.item['comimag'] != null
                        ? AssetImage(widget.item['comimag'])
                        : null,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  widget.item['Name'],
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: deepbrowncolor, fontSize: 29),
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
                    color: const Color(0xFF3D82AE),
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
                  Text(
                    widget.item['location'],
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: deepbrowncolor),
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
            Wheel(item: widget.item),
            const SizedBox(
              height: 10,
            ),
            // mirrors(),
            //  const SizedBox(
            //   height: 10,
            // ),
            // setes(),
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
        height: 90,
        width: 500,
        child: card,
      ),
    );
  }
}

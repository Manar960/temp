import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grad_proj/timeelinee/screens/home/widget/card_tile.dart';
import 'package:grad_proj/timeelinee/screens/home/widget/chart_card_tile.dart';
import 'package:grad_proj/timeelinee/screens/home/widget/project_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../config.dart';
import '../rating/rate.dart';

class ComponantBody extends StatefulWidget {
  const ComponantBody({Key? key}) : super(key: key);

  @override
  State<ComponantBody> createState() => _ComponantBodyState();
}

class _ComponantBodyState extends State<ComponantBody> {
  String companyName = '';
  int prodact = 0;
  int serv = 0;
  late int totalSP;
  int booking = 0;
  int ordars = 0;
  late int totalBR;
  int nigh = 0;
  int nighc = 0;
  int counterValue = 4;
  late int number=0;
  @override
  void initState() {
    super.initState();
    getCompanyName().then((value) {
      print('FIRST $companyName');
      fetchProdactCount();
      fetchServisesCount();
      fetchBookingCount();
      fetchOrdarsCount();
      fetchNighberCount();
      fetchNighbercomCount();
      getnumber(companyName);
    });
  }

  Future<void> getCompanyName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      companyName = prefs.getString('company') ?? '';
    });
  }

  Future<void> visetorCount() async {
    Timer.periodic(const Duration(hours: 3), (Timer timer) {
      // زيادة قيمة العداد بمقدار 5
      setState(() {
        counterValue += 5;
      });

      print("تمت زيادة قيمة العداد إلى: $counterValue");
    });
  }

  Future<void> fetchProdactCount() async {
    if (companyName == '') {
      print('prod $companyName');
    }
    final response =
        await http.get(Uri.parse('$getcompanysprodactcount/$companyName'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        prodact = data['count'];
        print('pro $companyName');
      });
    } else {
      print('Failed to fetch users count $companyName');
    }
  }

  Future<void> fetchServisesCount() async {
    final response =
        await http.get(Uri.parse('$getcompanysservicscount/$companyName'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        serv = data['count'];
        print('ser $companyName');
      });
    } else {
      print('Failed to fetch users count $companyName');
    }
  }

  Future<void> fetchBookingCount() async {
    final response =
        await http.get(Uri.parse('$getcompanysbookingcscount/$companyName'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        booking = data['count'];
        print('ser $companyName');
      });
    } else {
      print('Failed to fetch users count $companyName');
    }
  }

  Future<void> fetchOrdarsCount() async {
    final response =
        await http.get(Uri.parse('$getcompanysorfearscscount/$companyName'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        ordars = data['count'];
        print('ser $companyName');
      });
    } else {
      print('Failed to fetch users count $companyName');
    }
  }

  Future<void> fetchNighberCount() async {
    final response =
        await http.get(Uri.parse('$getcompanynighbercscount/$companyName'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        nigh = data['countUsersInCompanyLocation'];
        print('ser $companyName');
      });
    } else {
      print('Failed to fetch users count $companyName');
    }
  }

  Future<void> fetchNighbercomCount() async {
    final response =
        await http.get(Uri.parse('$getcompanynighbercomcscount/$companyName'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        nighc = data['count'];
        print('ser $companyName');
      });
    } else {
      print('Failed to fetch users count $companyName');
    }
  }

  Future<void> getnumber(String storeName) async {
  try {
    var response = await http.get(
      Uri.parse('https://gp-back-gp.onrender.com/Rating/length/Store-/$storeName'),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        number = jsonResponse['totalRatings'];
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during API request: $e');
  }
}
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    totalSP = serv + prodact;
    print('totalSP$totalSP');
    totalBR = ordars + booking;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (ResponsiveWidget.isSmallScreen(context)) ...[
              FractionallySizedBox(
                widthFactor: 0.3,
                child: CardTile(
                  iconBgColor: Colors.orange,
                  cardTitle: 'الطلبيات\nالحجوزات',
                  icon: Icons.work,
                  mainText: totalBR.toString(),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              FractionallySizedBox(
                widthFactor: 0.3,       
                child: CardTile(
                  iconBgColor: Colors.pinkAccent,
                  cardTitle: ' منتجات \n خدمات',
                  icon: Icons.category,
                  mainText: totalSP.toString(),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              FractionallySizedBox(
                widthFactor: 0.3,
                child: CardTile(
                  iconBgColor: Colors.green,
                  cardTitle: 'زبائن \n في الجوار',
                  icon: Icons.location_city,
                  mainText: nigh.toString(),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              FractionallySizedBox(
                widthFactor: 0.3,
                child: CardTile(
                  iconBgColor: Colors.lightBlueAccent,
                  cardTitle: 'شركات  \n في الجوار ',
                  icon: Icons.store,
                  mainText: nighc.toString(),
                ),
              ),
               const SizedBox(
                height: 40,
              ),
                FractionallySizedBox(
                widthFactor: 0.3,
                child: CardTile(
                  iconBgColor: Colors.orange,
                  cardTitle: 'التقييمات',
                  icon: Icons.reviews,
                  mainText: totalBR.toString(),
                ),
              ),
            ],
            if (!ResponsiveWidget.isSmallScreen(context))
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardTile(
                    iconBgColor: Colors.orange,
                    cardTitle: 'الطلبيات\nالحجوزات',
                    icon: Icons.work,
                    mainText: totalBR.toString(),
                  ),
                  CardTile(
                    iconBgColor: Colors.pinkAccent,
                    cardTitle: ' منتجات \n خدمات',
                    icon: Icons.category,
                    mainText: totalSP.toString(),
                  ),
                  CardTile(
                    iconBgColor: Colors.green,
                    cardTitle: 'زبائن \n في الجوار',
                    icon: Icons.location_city,
                    mainText: nigh.toString(),
                  ),
                  CardTile(
                    iconBgColor: Colors.lightBlueAccent,
                    cardTitle: 'شركات  \n في الجوار ',
                    icon: Icons.store,
                    mainText: nighc.toString(),
                  ),
                    InkWell(
                      onTap: () {
                     Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) {
                     return Reviwandcommint(companayname: companyName);
                }),
              );
                      },
                      child: CardTile(
                      iconBgColor: Color.fromARGB(255, 233, 255, 64),
                      cardTitle: 'التقييمات',
                      icon: Icons.reviews,
                      mainText: nighc.toString(),
                      ),
                    ),
                ],
              ),
            const SizedBox(
              height: 20,
            ),
            if (ResponsiveWidget.isSmallScreen(context)) ...[
              FractionallySizedBox(
                widthFactor: 0.8,
                child: ChartCardTile(
                  cardColor: const Color(0xFF7560ED),
                  cardTitle: 'عدد الزوار',
                  icon: Icons.people,
                  typeText: counterValue.toString(),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              FractionallySizedBox(
                widthFactor: 0.9,
                child: ProductWidget(
                  media: media,
                ),
              ),
            ],
            if (!ResponsiveWidget.isSmallScreen(context))
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ChartCardTile(
                    cardColor: const Color(0xFF7560ED),
                    cardTitle: 'عدد الزوار',
                    icon: Icons.people,
                    typeText: counterValue.toString(),
                  ),
                  ProductWidget(
                    media: media,
                  ),
                ],
              ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class ResponsiveComponantBody extends StatelessWidget {
  const ResponsiveComponantBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
      largeScreen: ComponantBody(),
      mediumScreen: ComponantBody(),
      smallScreen: ComponantBody(),
    );
  }
}

class ResponsiveWidget extends StatelessWidget {
  final Widget largeScreen;
  final Widget mediumScreen;
  final Widget smallScreen;

  const ResponsiveWidget({
    Key? key,
    required this.largeScreen,
    required this.mediumScreen,
    required this.smallScreen,
  }) : super(key: key);

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 800;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 800 &&
        MediaQuery.of(context).size.width < 1200;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return largeScreen;
        } else if (constraints.maxWidth < 1200 && constraints.maxWidth > 800) {
          return mediumScreen ?? largeScreen;
        } else {
          return smallScreen ?? largeScreen;
        }
      },
    );
  }
}

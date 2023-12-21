import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fron_end/timeelinee/screens/home/widget/card_tile.dart';
import 'package:fron_end/timeelinee/screens/home/widget/chart_card_tile.dart';
import 'package:fron_end/timeelinee/screens/home/widget/project_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../config.dart';

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
    });
  }

  Future<void> getCompanyName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      companyName = prefs.getString('company') ?? '';
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

  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
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
                ],
              ),
            const SizedBox(
              height: 20,
            ),
            if (ResponsiveWidget.isSmallScreen(context)) ...[
              const FractionallySizedBox(
                widthFactor: 0.8,
                child: ChartCardTile(
                  cardColor: Color(0xFF7560ED),
                  cardTitle: 'Bandwidth usage',
                  icon: Icons.pie_chart,
                  typeText: '50 GB',
                ),
              ),
              SizedBox(
                height: 40,
              ),
              FractionallySizedBox(
                widthFactor: 0.9,
                child: ProjectWidget(media: _media),
              ),
            ],
            if (!ResponsiveWidget.isSmallScreen(context))
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const ChartCardTile(
                    cardColor: Color(0xFF7560ED),
                    cardTitle: 'Bandwidth usage',
                    icon: Icons.pie_chart,
                    typeText: '50 GB',
                  ),
                  ProjectWidget(media: _media),
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

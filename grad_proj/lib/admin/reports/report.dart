import 'dart:convert';

import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';
import '../common/app_colors.dart';
import '../pages/dashboard/widget/header_widget.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  int totalUsers = 0;
  int expertsCount = 0;
  int companies = 0;
  int prodacts = 0;
  int servis = 0;
  int booking = 0;
  int ordars = 0;
  int pro = 0;
  int ser = 0;

  @override
  void initState() {
    super.initState();
    fetchCompaniesCount();
    fetchUsersCount();
    fetchExpCount();
    fetchbookingCount();
    fetchOrdount();
    fetchProCount();
    fetchSerCount();
  }

  Future<void> fetchCompaniesCount() async {
    final response = await http.get(Uri.parse(getComCount));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        companies = data['count'];
      });
    } else {
      print('Failed to fetch companies count');
    }
  }

  Future<void> fetchUsersCount() async {
    final response = await http.get(Uri.parse(getUsersCount));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        totalUsers = data['count'];
      });
    } else {
      print('Failed to fetch users count');
    }
  }

  Future<void> fetchExpCount() async {
    final response = await http.get(Uri.parse(getExpCount));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        expertsCount = data['count'];
      });
    } else {
      print('Failed to fetch users count');
    }
  }

  Future<void> fetchbookingCount() async {
    final response = await http.get(Uri.parse(getExpCount));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        booking = data['count'];
      });
    } else {
      print('Failed to fetch users count');
    }
  }

  Future<void> fetchOrdount() async {
    final response = await http.get(Uri.parse(getOrderCount));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        ordars = data['count'];
      });
    } else {
      print('Failed to fetch users count');
    }
  }

  Future<void> fetchProCount() async {
    final response = await http.get(Uri.parse(getProCount));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        pro = data['count'];
      });
    } else {
      print('Failed to fetch users count');
    }
  }

  Future<void> fetchSerCount() async {
    final response = await http.get(Uri.parse(getSerCount));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        ser = data['count'];
      });
    } else {
      print('Failed to fetch users count');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColor.bgColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            const HeaderWidget(
              title: 'التقارير',
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(
                              color: Colors.blueGrey, width: 0.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "المستخدمون ",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 0.3,
                              endIndent: 10,
                              indent: 10,
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: _buildChart(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildLegendItem(Colors.blue, "Users",
                                      totalUsers.toString()),
                                  _buildLegendItem(Colors.green, "Experts",
                                      expertsCount.toString()),
                                  _buildLegendItem(Colors.orange, "Companies",
                                      companies.toString()),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildInfoCard(
                        icon: Icons.shopping_cart,
                        title: 'المنتجات',
                        value: pro.toString(),
                      ),
                      _buildInfoCard(
                        icon: Icons.build,
                        title: 'الخدمات',
                        value: booking.toString(),
                      ),
                      _buildInfoCard(
                        icon: Icons.shopping_basket,
                        title: 'الطلبات',
                        value: ordars.toString(),
                      ),
                      _buildInfoCard(
                        icon: Icons.calendar_today,
                        title: 'الحجوزات',
                        value: ser.toString(),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(
                              color: Colors.blueGrey, width: 0.8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SimpleMap(
                            instructions: SMapWorld.instructions,
                            defaultColor: Colors.grey,
                            colors: const SMapWorldColors(
                              iL: Colors.green,
                              jO: Colors.red,
                              eG: Colors.yellow,
                              lB: Colors.blue,
                              sY: Colors.yellow,
                            ).toMap(),
                            callback: (id, name, tapdetails) {
                              print(id);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  const Text(
                    'المدن الفلسطينية',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    padding: const EdgeInsets.all(10),
                    child: _buildCityChart(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCityChart() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        border: Border.all(color: Colors.blueGrey, width: 2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(show: false),
            titlesData: const FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            minX: 0,
            maxX: 6,
            minY: 0,
            maxY: 100,
            lineBarsData: [
              LineChartBarData(
                spots: _getCityLineSpots(),
                isCurved: true,
                color: Colors.cyan,
                belowBarData: BarAreaData(show: false),
                dotData: const FlDotData(show: true),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<FlSpot> _getCityLineSpots() {
    return [
      const FlSpot(0, 20),
      const FlSpot(1, 40),
      const FlSpot(2, 60),
      const FlSpot(3, 80),
      const FlSpot(4, 90),
      const FlSpot(5, 70),
      const FlSpot(6, 50),
    ];
  }

  Widget _buildChart() {
    return PieChart(
      PieChartData(
        sections: _getChartSections(),
        centerSpaceRadius: 40,
        startDegreeOffset: 180,
        borderData: FlBorderData(show: false),
        sectionsSpace: 0,
      ),
    );
  }

  List<PieChartSectionData> _getChartSections() {
    return [
      PieChartSectionData(
        color: Colors.blue,
        value: totalUsers.toDouble(),
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.green,
        value: expertsCount.toDouble(),
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.orange,
        value: companies.toDouble(),
        radius: 50,
      ),
    ];
  }

  Widget _buildLegendItem(Color color, String title, String value) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        const SizedBox(width: 8),
        Text("$title: $value"),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return SizedBox(
      width: 150,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: Colors.blueGrey, width: 0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30,
                color: Colors.blue,
              ),
              const SizedBox(height: 10),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fron_end/timeelinee/screens/home/widget/card_tile.dart';
import 'package:fron_end/timeelinee/screens/home/widget/chart_card_tile.dart';
import 'package:fron_end/timeelinee/screens/home/widget/project_widget.dart';

class ComponantBody extends StatefulWidget {
  const ComponantBody({Key? key}) : super(key: key);

  @override
  State<ComponantBody> createState() => _ComponantBodyState();
}

class _ComponantBodyState extends State<ComponantBody> {
  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (ResponsiveWidget.isSmallScreen(context)) ...[
              const FractionallySizedBox(
                widthFactor: 0.3,
                child: CardTile(
                  iconBgColor: Colors.orange,
                  cardTitle: 'الطلبيات\nالحجوزات',
                  icon: Icons.work,
                  mainText: '230',
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const FractionallySizedBox(
                widthFactor: 0.3,
                child: CardTile(
                  iconBgColor: Colors.pinkAccent,
                  cardTitle: 'Website Visits',
                  icon: Icons.category,
                  mainText: '3.560',
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const FractionallySizedBox(
                widthFactor: 0.3,
                child: CardTile(
                  iconBgColor: Colors.green,
                  cardTitle: 'Revenue',
                  icon: Icons.location_city,
                  mainText: '2500',
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const FractionallySizedBox(
                widthFactor: 0.3,
                child: CardTile(
                  iconBgColor: Colors.lightBlueAccent,
                  cardTitle: 'Followers',
                  icon: Icons.store,
                  mainText: '112',
                ),
              ),
            ],
            if (!ResponsiveWidget.isSmallScreen(context))
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardTile(
                    iconBgColor: Colors.orange,
                    cardTitle: 'الطلبيات\nالحجوزات',
                    icon: Icons.work,
                    mainText: '230',
                  ),
                  CardTile(
                    iconBgColor: Colors.pinkAccent,
                    cardTitle: 'Website Visits',
                    icon: Icons.category,
                    mainText: '3.560',
                  ),
                  CardTile(
                    iconBgColor: Colors.green,
                    cardTitle: 'Revenue',
                    icon: Icons.location_city,
                    mainText: '2500',
                  ),
                  CardTile(
                    iconBgColor: Colors.lightBlueAccent,
                    cardTitle: 'Followers',
                    icon: Icons.store,
                    mainText: '112',
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

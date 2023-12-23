import 'package:flutter/material.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'utils/content_view.dart';
import 'utils/tab_controller_handler.dart';
import 'utils/view_wrapper.dart';
import 'views/about_view.dart';
import 'views/home_view.dart';
import 'views/projects_view.dart';
import 'widgets/bottom_bar.dart';
import 'widgets/custom_tab.dart';
import 'widgets/custom_tab_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late ItemScrollController itemScrollController;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  late double screenHeight;
  late double screenWidth;
  late double topPadding;
  late double bottomPadding;
  late double sidePadding;

  List<ContentView> contentViews = [
    ContentView(
      tab: const CustomTab(title: ' أهلاً'),
      content: const HomeView(),
    ),
    ContentView(
      tab: const CustomTab(title: 'ماذا نقدم'),
      content: const AboutView(
        key: Key('16'),
      ),
    ),
    ContentView(
      tab: const CustomTab(title: ' انضم لنا '),
      content: const ProjectsView(
        key: Key('17'),
      ),
    )
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: contentViews.length, vsync: this);
    itemScrollController = ItemScrollController();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    topPadding = screenHeight * 0.05;
    bottomPadding = screenHeight * 0.03;
    sidePadding = screenWidth * 0.05;

    // ignore: avoid_print
    print('Width: $screenWidth');
    // ignore: avoid_print
    print('Height: $screenHeight');
    return Scaffold(
      backgroundColor: Color.fromARGB(0, 255, 255, 255),
      key: scaffoldKey,
      endDrawer: drawer(),
      body: Padding(
        padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
        child: ViewWrapper(
          desktopView: desktopView(),
          mobileView: mobileView(),
          key: const Key('19'),
        ),
      ),
    );
  }

  Widget desktopView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start, // Change to start alignment
      children: [
        /// Tab Bar
        SizedBox(
          height: screenHeight * 0.05,
         
        ),

        /// Tab Bar View
        SizedBox(
          height: screenHeight * 0.8,
          child: TabControllerHandler(
            tabController: tabController,
            key: const Key('20'),
            child: TabBarView(
              controller: tabController,
              children: contentViews.map((e) => e.content).toList(),
            ),
          ),
        ),

        /// Bottom Bar as part of the Row
        Row(
          children: [
            BottomBar(
              key: Key('21'),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }

  Widget mobileView() {
    return Padding(
      padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
      child: SizedBox(
        width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                iconSize: screenWidth * 0.08,
                icon: const Icon(Icons.menu_rounded),
                color: Colors.black,
                splashColor: Colors.black,
                onPressed: () => scaffoldKey.currentState!.openEndDrawer()),
            Expanded(
              child: ScrollablePositionedList.builder(
                scrollDirection: Axis.vertical,
                itemScrollController: itemScrollController,
                itemCount: contentViews.length,
                itemBuilder: (context, index) => contentViews[index].content,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget drawer() {
    return SizedBox(
      width: screenWidth * 0.5,
      child: Drawer(
        child: ListView(
          children: [Container(height: screenHeight * 0.1)] +
              contentViews
                  // ignore: avoid_unnecessary_containers
                  .map((e) => Container(
                        child: ListTile(
                          title: Text(
                            e.tab.title,
                            // ignore: deprecated_member_use
                            style: Theme.of(context).textTheme.button,
                          ),
                          onTap: () {
                            itemScrollController.scrollTo(
                                index: contentViews.indexOf(e),
                                duration: const Duration(milliseconds: 300));
                            Navigator.pop(context);
                          },
                        ),
                      ))
                  .toList(),
        ),
      ),
    );
  }
}

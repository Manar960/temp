import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:lottie/lottie.dart';

import '../../../login/Login/login_screen.dart';
import '../../../login/Signup/sighnup_company.dart';
import '../../../login/Signup/signup_screen.dart';
import '../utils/project_model.dart';
import '../utils/theme_selector.dart';
import '../utils/view_wrapper.dart';
import '../widgets/navigation_arrow.dart';
import '../widgets/project_entry.dart';
import '../widgets/project_image.dart';

class ProjectsView extends StatefulWidget {
  const ProjectsView({required Key key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProjectsViewState createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView> {
  late double screenWidth;
  late double screenHeight;
  int selectedIndex = 0;
  List<Project> projects = [
    Project(
        title: 'تسجيل الدخول',
        imageURL: 'assets/login.json',
        description:
            '  في حال كنت جزءً من مجتمعنا ، و تمتلك حساب من قبل ، قم بتسجيل الدخول بالضغط على الزر الذي بالأسفل لتنتقل إلى صفحة تسجيل الدخول ، قم بملئ المعلومات الصحيحة في المكان المناسب لها و استمتع بالتجربة أما لو كنت لا تمتلك حساب استعمل الصور في اليمين لتسجل حسابك كمستخدم أو كشركة'),
    Project(
        title: 'إنشاء حساب ',
        imageURL: 'assets/sighnup.json',
        description:
            '  أهلا بك ، قم بالضغط على الزر الذي بالأسفل لتتمكن من إنشاء حساب و زبوناً على منصتنا تتمتع بكافة المزايا من طلب و تتبع و بحث ، قم بتعبئة المعلومات المطلوبة و ابدأ رحلتك الآن   '),
    Project(
        title: 'إنضم كمؤسسة',
        imageURL: 'assets/com_reg.json',
        description:
            '     أهلا بك ، في حال كانت لديك خدمة او منتج ترغب في طرحهم ضمن منصتنا قم بتعبئة الطلب عن طريق الضغط على الر في الاسفل و أنتظر الرد لتحصل على حساب عملك الخاص     '),
  ];

  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage('assets/login.json'), context);
    precacheImage(const AssetImage('assets/sighnup.json'), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return ViewWrapper(
      desktopView: desktopView(),
      mobileView: mobileView(),
      key: const Key('20'),
    );
  }

  Widget desktopView() {
    double space = MediaQuery.of(context).size.height * 0.03;
    List<Widget> images =
        List.generate((projects.length * 1.5).ceil(), (index) {
      if (index.isEven) {
        return ProjectImage(
          project: projects[index ~/ 2],
          onPressed: () => updateIndex(index ~/ 2),
          key: UniqueKey(),
        );
      } else {
        return SizedBox(height: space);
      }
    });
    return Stack(
      children: [
        const NavigationArrow(
          isBackArrow: true,
          key: Key('12'),
        ),
        Padding(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.05, horizontal: screenWidth * 0.1),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: images,
                ),
                SizedBox(width: space),
                SizedBox(
                  height: screenHeight * 0.2 * 2 + space * 2,
                  child: Stack(
                    children: [
                      AnimatedAlign(
                        alignment: selectedIndex == 0
                            ? Alignment.topCenter
                            : selectedIndex == 1
                                ? Alignment.center
                                : Alignment.bottomCenter,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.fastOutSlowIn,
                        child: Container(
                          color: Colors.white,
                          width: screenWidth * 0.05,
                          height: 3,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: space),
                Directionality(
                    textDirection: TextDirection
                        .rtl, // Set text direction to left-to-right (ltr)
                    child: Expanded(
                        child: ProjectEntry(
                      project: projects[selectedIndex],
                      key: const Key('10'),
                    ))),
              ],
            )),
        Positioned(
          top: 300.0,
          left: 800.0,
          child: ElevatedButton(
            onPressed: () {
              if (selectedIndex == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              } else if (selectedIndex == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                );
              } else if (selectedIndex == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignUpScreenCom()),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // لون الزر
            ),
            child: Text(projects[selectedIndex].title,
                style: const TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget mobileView() {
    List<Widget> projectList = List.generate(projects.length, (index) {
      return Column(
        children: [
          Text(
            projects[index].title,
            style: ThemeSelector.selectSubHeadline(context),
          ),
          SizedBox(height: screenHeight * 0.01),
          SizedBox(
            height: screenHeight * 0.1,
            width: screenWidth,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Lottie.asset(
                projects[index].imageURL,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            projects[index].description,
            style: ThemeSelector.selectBodyText(context),
          ),
          SizedBox(height: screenHeight * 0.1),
          ElevatedButton(
            onPressed: () {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                );
              } else if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignUpScreenCom()),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // لون الزر
            ),
            child: Text(
              projects[index].title,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    });
    return Column(children: projectList);
  }

  void updateIndex(int newIndex) {
    setState(() {
      selectedIndex = newIndex;
    });
  }
}

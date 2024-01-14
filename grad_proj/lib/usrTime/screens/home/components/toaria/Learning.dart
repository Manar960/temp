// ignore: file_names
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../timeelinee/screens/home/components/home_header.dart';
import 'LearningCard.dart';

// ignore: must_be_immutable
class LearningPage extends StatelessWidget {
  LearningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: HomeHeader(),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final isWideScreen = screenWidth > 600;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: isWideScreen ? 400 : screenWidth,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: isWideScreen ? 1.0 : 1.0,
            ),
            itemCount: learningCards.length,
            itemBuilder: (context, index) {
              return LearningCard(
                image: learningCards[index].image,
                title: learningCards[index].title,
                description: learningCards[index].description,
              );
            },
          );
        },
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            _showLinksDialog(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF063970),
            textStyle: const TextStyle(color: Colors.white),
          ),
          child: const Text('الروابط'),
        ),
      ],
    );
  }

  void _showLinksDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'مصادر تعليمية',
            textDirection: TextDirection.rtl,
            style: TextStyle(color: Color(0xFF063970)),
          ),
          content: SizedBox(
            width: 200,
            child: ListView(
              shrinkWrap: true,
              children: [
                InkWell(
                  onTap: () {
                    // ignore: avoid_print
                    print('تم النقر على الرابط 1');
                    _launchURL('https://www.youtube.com/watch?v=9Ezf1P3LlxY');
                  },
                  child: const Text(
                    'شرح دوسية التوريا الجزء الاول',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Color(0xFF063970), fontSize: 18),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // ignore: avoid_print
                    print('تم النقر على الرابط 2');
                    _launchURL('https://www.youtube.com/watch?v=TTkzV44FlEw');
                  },
                  child: const Text(
                    'شرح التؤوريا معرفة مركبة الجزء الثاني',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Color(0xFF063970), fontSize: 18),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // ignore: avoid_print
                    print('شرح اشارات المرور');
                    _launchURL(
                        'https://www.youtube.com/playlist?list=PL6tgCB5OB7IaPJ2Gxa7XpOqqUrO6kDECa');
                  },
                  child: const Text(
                    'شرح اشارات المرور',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Color(0xFF063970), fontSize: 18),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // ignore: avoid_print
                    print('كتاب التؤوريا');
                    _launchURL('https://www.al-ahliya.com/eb/1540020001.pdf');
                  },
                  child: const Text(
                    'كتاب التؤوريا',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Color(0xFF063970), fontSize: 18),
                  ),
                )
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF063970),
                textStyle: const TextStyle(color: Colors.white),
              ),
              child: const Text('إغلاق'),
            ),
          ],
        );
      },
    );
  }

  void _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  List<LearningCardData> learningCards = [
    const LearningCardData(
      image: "assets/tou/Screenshot from 2024-01-11 09-36-18.png",
      title: "طريق وعرة أو مشوشة",
      description: "إشارة تحذير",
    ),
    const LearningCardData(
      image: "assets/tou/Screenshot from 2024-01-11 09-38-46.png",
      title: "انعطاف حاد إلى اليسار",
      description: "إشارة تحذير",
    ),
    const LearningCardData(
      image: "assets/tou/Screenshot from 2024-01-11 09-40-20.png",
      title: "انعطاف حاد إلى اليمين",
      description: "إشارة تحذير",
    ),
    const LearningCardData(
      image: "assets/tou/Screenshot from 2024-01-11 09-41-55.png",
      title: "مغلق أمام جميع المركبات (كلا الاتجاهين)",
      description: "إشارة الإرشاد",
    ),
    const LearningCardData(
      image: "assets/tou/Screenshot from 2024-01-11 09-41-55.png",
      title: "مغلق أمام جميع المركبات (اتجاه واحد)",
      description: "إشارة الإرشاد",
    ),
  ];
}

class LearningCardData {
  final String image;
  final String title;
  final String description;

  const LearningCardData({
    required this.image,
    required this.title,
    required this.description,
  });
}

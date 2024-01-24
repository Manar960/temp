import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:grad_proj/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../butombar.dart';
import '../../map/map.dart';
import '../booking/boking_screen.dart';
import '../cart/cart_screen.dart';
import '../home/home_screen.dart';
import 'Ratingbar1.dart';

class Reviwandcommint extends StatefulWidget {
  const Reviwandcommint({Key? key, required this.item}) : super(key: key);
  final Map<String, dynamic> item;

  @override
  _ReviwandcommintState createState() => _ReviwandcommintState();
}

class _ReviwandcommintState extends State<Reviwandcommint> {
  late String rates = '0.0';
  late double adjustRate = 0;
  late Map<String, dynamic> star = {
    "1": 0.0,
    "2": 0.0,
    "3": 0.0,
    "4": 0.0,
    "5": 0.0,
  };
  Future<void> getAvareg(String Name) async {
    try {
      var response = await http.get(
        Uri.parse(
            'https://gp-back-gp.onrender.com/Rating/Avareg--rate/Store/$Name'),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setState(() {
          rates = jsonResponse['averageRating'];
          adjustRate = jsonResponse['adjustedRate'];
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during API request: $e');
    }
  }

  Future<void> getAvaregstar(String Name) async {
    try {
      var response = await http.get(
        Uri.parse(
            'https://gp-back-gp.onrender.com/Rating/persantge-of-each-star/$Name'),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setState(() {
          star = jsonResponse['data'];
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during API request: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getAvareg(widget.item['Name']);
    getAvaregstar(widget.item['Name']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('التقييم والمراجعة'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            Trating(
              rate: rates,
              star: star,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Ratingbar(rate: adjustRate),
            ),
            const SizedBox(
              height: 30,
            ),
            Ratingbar1(item: widget.item)
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
}

class Ratingbar extends StatelessWidget {
  const Ratingbar({
    Key? key,
    required this.rate,
  }) : super(key: key);

  final double rate;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rate,
      itemSize: 20,
      textDirection: TextDirection.ltr,
      direction: Axis.horizontal,
      itemBuilder: (_, __) => const Icon(
        Icons.star,
        color: Colors.yellow,
      ),
    );
  }
}

class Trating extends StatelessWidget {
  const Trating({
    Key? key,
    required this.rate,
    required this.star,
  }) : super(key: key);

  final String rate;
  final Map<String, dynamic> star;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: Column(
            children: [
              Ratingprogress(text: "5", value: star["5"] ?? 0),
              Ratingprogress(text: "4", value: star["4"] ?? 0),
              Ratingprogress(text: "3", value: star["3"] ?? 0),
              Ratingprogress(text: "2", value: star["2"] ?? 0),
              Ratingprogress(text: "1", value: star["1"] ?? 0),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            rate,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
      ],
    );
  }
}

class Ratingprogress extends StatelessWidget {
  const Ratingprogress({
    Key? key,
    required this.text,
    required this.value,
  }) : super(key: key);

  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 11,
          child: SizedBox(
            width: double.infinity,
            child: RotatedBox(
              quarterTurns: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: LinearProgressIndicator(
                  value: value,
                  minHeight: 11,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: const AlwaysStoppedAnimation(bluebasic),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          flex: 1,
          child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }
}

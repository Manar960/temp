import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../../models/user.dart';
import 'counter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterWithFavBtn extends StatefulWidget {
  const CounterWithFavBtn({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Map<String, dynamic> item;

  @override
  _CounterWithFavBtnState createState() => _CounterWithFavBtnState();
}
    String? username = AuthProvider.userData?.userName;

class _CounterWithFavBtnState extends State<CounterWithFavBtn> {
  late bool active;

  @override
  void initState() {
    super.initState();
    loadLikedState();
  }

  Future<void> loadLikedState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      active = prefs.getBool(widget.item['Name']) ?? false;
    });
  }

  Future<void> saveLikedState(bool liked) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(widget.item['Name'], liked);
  }

  Future<void> addtofav(String UserName, String ProName, String Proimage) async {
    final url = 'https://gp-back-gp.onrender.com/Fav';
    print(UserName);
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "UserName": UserName,
        "ProName": ProName,
        "Proimage": Proimage,
      }),
    );

    if (response.statusCode == 200) {
      print('done');
    } else {
      print('Failed: ${response.statusCode}');
    }
  }

  Future<void> removeFromfav(String proname) async {
    final url = 'https://gp-back-gp.onrender.com/deletefav/$proname';

    final response = await http.delete(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'ProName': proname,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CartCounter(item: widget.item),
        InkWell(
          onTap: () {
            setState(() {
              active = !active;
            });
            saveLikedState(active); 
            if (active) {
              addtofav(username!, widget.item['Name'], widget.item['proimage']);
            } else {
              removeFromfav(widget.item['Name']);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            child: Icon(
              active ? Icons.favorite : Icons.favorite_border,
              size: 30,
              color: active ? Colors.redAccent[700] : Colors.black,
            ),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

class about extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.black12,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Trafegar Water D Low',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',
              ),
            ),
            Text(
              'surgeon',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20.0,
                fontFamily: 'Source Sans Pro',
              ),
            ),
            SizedBox(
              height: 20.0,
              width: 150.0,
              child: Divider(
                color: Colors.white,
              ),
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.work,
                  color: Colors.black,
                  size: 30.0,
                ),
                title: Text(
                  'Heart Pirate Leader',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: 'Source Sans Pro',
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.currency_bitcoin,
                  color: Colors.black,
                  size: 30.0,
                ),
                title: Text(
                  '500.000.000',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: 'Source Sans Pro',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

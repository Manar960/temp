import 'package:flutter/material.dart';

import 'category.dart';

class StokScreenPage extends StatefulWidget {
  const StokScreenPage({super.key});

  @override
  _StokScreenPageState createState() => _StokScreenPageState();
}

class _StokScreenPageState extends State<StokScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StokScreen(
          media: MediaQuery.of(context).size,
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';

import 'bullet_point.dart';

class BulletList extends StatefulWidget {
  const BulletList(
      {required Key key, required this.strings, required TextAlign textAlign})
      : super(key: key);
  final List<String> strings;

  @override
  // ignore: library_private_types_in_public_api
  _BulletListState createState() => _BulletListState();
}

class _BulletListState extends State<BulletList>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    Timer(const Duration(milliseconds: 200),
        () => _animationController.forward());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.strings.length * 2, (index) {
        if (index.isEven) {
          return Flexible(
              flex: 2,
              child: BulletPoint(
                text: widget.strings[index ~/ 2],
                animationController: _animationController,
                index: index ~/ 2,
                key: const Key('7'),
              ));
        } else {
          return const Spacer(flex: 1);
        }
      }),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

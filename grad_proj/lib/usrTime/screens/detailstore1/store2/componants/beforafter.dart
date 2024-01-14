import 'package:flutter/material.dart';
import 'package:before_after/before_after.dart';

import '../../detailpage/componant/responsive.dart';

// ignore: use_key_in_widget_constructors
class EffectHorizontalWidget extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _EffectHorizontalWidgetState createState() => _EffectHorizontalWidgetState();
}

class _EffectHorizontalWidgetState extends State<EffectHorizontalWidget> {
  double thumbPosition = 0.5;
  bool isDragging = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isDragging = true;
          });
        },
        onExit: (_) {
          setState(() {
            isDragging = false;
          });
        },
        onHover: (event) {
          if (isDragging) {
            setState(() {
              thumbPosition = event.localPosition.dx / 300;
              thumbPosition = thumbPosition.clamp(0.0, 1.0);
            });
          }
        },
        child: BeforeAfter(
          before: Image.asset('assets/images/be.png', fit: BoxFit.cover),
          after: Image.asset('assets/images/af.png', fit: BoxFit.cover),
          height: 500,
          width: 700,
          thumbHeight: 24.0,
          thumbWidth: 24.0,
          thumbColor: Colors.red,
          overlayColor: MaterialStateProperty.all(Colors.white24),
          direction: SliderDirection.horizontal,
          value: thumbPosition,
        ),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class EffectHorizontalWidget2 extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _EffectHorizontalWidgetState2 createState() =>
      _EffectHorizontalWidgetState2();
}

class _EffectHorizontalWidgetState2 extends State<EffectHorizontalWidget2> {
  double thumbPosition = 0.5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          setState(() {
            thumbPosition += details.primaryDelta! / 300;
            thumbPosition = thumbPosition.clamp(0.0, 1.0);
          });
        },
        child: BeforeAfter(
          before: Image.asset('assets/images/be.png', fit: BoxFit.cover),
          after: Image.asset('assets/images/af.png', fit: BoxFit.cover),
          height: 300,
          width: 300,
          thumbHeight: 24.0,
          thumbWidth: 24.0,
          thumbColor: Colors.red,
          overlayColor: MaterialStateProperty.all(Colors.white24),
          direction: SliderDirection.horizontal,
          value: thumbPosition,
        ),
      ),
    );
  }
}

Widget horizontalWidgetBasedOnScreenType(BuildContext context) {
  if (Responsive.isDesktop(context)) {
    return Center(
      child: EffectHorizontalWidget(),
    );
  } else if (Responsive.isMobile(context)) {
    return Center(
      child: EffectHorizontalWidget2(),
    );
  }
  return Container();
}

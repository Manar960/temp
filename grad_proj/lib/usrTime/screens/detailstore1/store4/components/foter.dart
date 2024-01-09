import 'package:flutter/material.dart';

import '../../../../../login/responsive.dart';

class foter extends StatelessWidget {
  const foter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Center(
              child: Image.asset(
                "assets/images/ad3.png",
                   height: Responsive.isDesktop(context)
                          ? 400 
                          : 200, 
                      width: Responsive.isDesktop(context)
                          ? 1230 
                          : 500,
                fit: BoxFit.fill,
              ),
            )),
       
       
      ],
    );
  }
}
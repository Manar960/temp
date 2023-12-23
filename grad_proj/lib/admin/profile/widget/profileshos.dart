import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';

import '../../../landing/navebar/utils/theme_selector.dart';

class btton {
  btton({required this.title, required this.imageURL});

  final String title;
  final String imageURL;
}

class ProjectEntry extends StatelessWidget {
  const ProjectEntry({required Key key, required this.Btton}) : super(key: key);
  final btton Btton;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Text(
          Btton.title,
          style: ThemeSelector.selectSubHeadline(context),
        ),
        SizedBox(height: screenHeight * 0.05),
      ],
    );
  }
}

class ProjectImage extends StatelessWidget {
  const ProjectImage(
      {required Key key, required this.project, required this.onPressed})
      : super(key: key);
  final btton project;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    double imageSize = MediaQuery.of(context).size.height * 0.2;
    return Theme(
      data: ThemeData(
          splashColor: Colors.transparent, highlightColor: Colors.transparent),
      child: HoverCrossFadeWidget(
          firstChild: SizedBox(
            height: imageSize,
            width: imageSize,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                project.imageURL,
                fit: BoxFit.cover,
              ),
            ),
          ),
          secondChild: InkWell(
            onTap: onPressed,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                height: imageSize,
                width: imageSize,
                child: Center(
                  child: Text(
                    project.title,
                    style: const TextStyle(color: Colors.black),
                  ),
                )),
          ),
          duration: const Duration(milliseconds: 200)),
    );
  }
}

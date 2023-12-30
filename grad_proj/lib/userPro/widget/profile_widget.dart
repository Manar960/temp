import 'dart:typed_data';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final Uint8List? imageBytes; // Added to handle the selected image

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
    this.imageBytes, // Added this parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(imagePath, imageBytes),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color, onClicked),
          ),
        ],
      ),
    );
  }

  Widget buildImage(String imagePath, Uint8List? imageBytes) {
    final imageProvider = imageBytes != null
        ? MemoryImage(Uint8List.fromList(imageBytes))
        : NetworkImage(imagePath) as ImageProvider<Object>;

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: imageProvider,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color, VoidCallback onClicked) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: const Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Store extends StatelessWidget {
  const Store(
      {Key? key,
      this.width = 300,
      this.aspectRetio = 1.02,
      required this.onPress,
      required this.image,
      required this.title,
      required this.rating})
      : super(key: key);
  final String image, title;
  final double width, aspectRetio, rating;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.02,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 2, 76, 172).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(image),
              ),
            ),
            Center(
              child: RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  // Handle rating updates if needed
                },
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'model.dart';

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: demo_categories.length,
          itemBuilder: (context, index) => CategoryCard(
            icon: demo_categories[index].icon,
            title: demo_categories[index].title,
            press: () {},
          ),
          separatorBuilder: (context, index) => const SizedBox(width: 16),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String icon, title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: press,
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: 16 / 2, horizontal: 16 / 4),
        child: Column(
          children: [
            SvgPicture.asset(
              icon,
              height: 38,
              width: 50,
            ),
            const SizedBox(height: 16 / 2),
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle2,
            )
          ],
        ),
      ),
    );
  }
}

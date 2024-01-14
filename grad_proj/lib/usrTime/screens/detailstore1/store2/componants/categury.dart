import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


import 'cat.dart';
import 'pro.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key, required this.item}) : super(key: key);
   final Map<String, dynamic> item;

  @override
  _CategoriesState createState() => _CategoriesState();
}


class _CategoriesState extends State<Categories> {
  TextEditingController _date = TextEditingController();
       String? selectedType; 
     String? selectedModel;
     String? selectedFuelType;
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Container(
      alignment: Alignment.center,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _size.width < 650 ? 1 : 2,
          childAspectRatio: 3,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
        ),
        itemBuilder: (context, index) => CategoryCard(
          icon: demo_categories[index].icon,
          title: demo_categories[index].title,
          press: () {
              if (index == 0) {
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => productstore2(item: widget.item),
              ),
            );
            }
        
          },
        ),
        itemCount: demo_categories.length,
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
    return GestureDetector(
      onTap: press,
      child: Container(
        height: 200,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              icon,
              height: 200,
              width: 200,
            ),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}






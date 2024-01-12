import 'package:flutter/material.dart';
import '../../../../../../constants.dart';
import '../../detailpage/componant/responsive.dart';
import 'cards.model.dart';

class BrandCards extends StatelessWidget {
  const BrandCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Responsive(
            desktop: ProductCard(
              crossAxiscount: size.width < 650 ? 2 : 4,
              aspectRatio: size.width < 650 ? .1 : 2,
            ),
            tablet: ProductCard(
              crossAxiscount: size.width < 825 ? 2 : 4,
              aspectRatio: size.width < 825 ? 0.85 : 2,
            ),
            mobile: ProductCard(
              crossAxiscount: size.width < 690 ? 2 : 4,
              aspectRatio: size.width < 560 ? 1.4 : 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class Services1 extends StatelessWidget {
  const Services1({
    Key? key,
    required this.card,
  }) : super(key: key);

  final cardsprand card;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPadding),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 150,
          padding: const EdgeInsets.all(kPadding / 2),
          color: pagecolor,
          child: Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  card.image1,
                  height: Responsive.isDesktop(context) ? 80 : 60,
                  width: Responsive.isDesktop(context) ? 80 : 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      card.title,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      card.title2,
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.crossAxiscount = 0,
    this.aspectRatio = 0.3,
  }) : super(key: key);

  final int crossAxiscount;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxiscount,
        childAspectRatio: aspectRatio,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemBuilder: (context, index) => Services1(
        card: cards[index],
      ),
      itemCount: cards.length,
    );
  }

  // ignore: unused_element
  Widget _buildCard(Widget card) {
    return Container(
      margin: const EdgeInsets.all(kPadding / 2),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFFBAEAE), width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: card,
    );
  }
}

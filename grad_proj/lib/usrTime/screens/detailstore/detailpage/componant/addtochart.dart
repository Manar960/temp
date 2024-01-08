import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../dialog.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Map<String, dynamic> item;

  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16),
            height: 50,
            width: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
              child: SvgPicture.asset("assets/icons/add_to_cart.svg"),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // addtocart.addToaddtocart([widget.item]);
                showCards(
                  context,
                  "assets/car1.json",
                  'تمت اضافة المنتج',
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                backgroundColor: Colors.black,
              ),
              child: const Text(
                "اضف الى السلة",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

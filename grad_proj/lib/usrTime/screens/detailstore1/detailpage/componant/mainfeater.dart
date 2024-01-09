
import 'package:flutter/material.dart';

import '../../../../../../constants.dart';
import 'responsive.dart';


class pagedetail extends StatelessWidget {
  const pagedetail({super.key, required this.item});
final Map<String, dynamic> item;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "معلومات اضافية",
            style: TextStyle(color: Colors.white),
          ),
          Text(
           item['Name'],
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          
              SizedBox(
  width: Responsive.isDesktop(context) ? kPadding*30 : kPadding*5,
)
,
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(text: "السعر\n"),
                    TextSpan(
                      text: "\$${item['price']}",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
               SizedBox(width: Responsive.isDesktop(context)?kPadding*50:kPadding*5),
                 Expanded(
                  child: Hero(
                    tag: "${item['_id']}",
                    child: Container(
                      width: Responsive.isDesktop(context)?150:100,  
                      height: Responsive.isDesktop(context)?250:200,
                      child: Image.asset(
                        item['proimage'],
                        fit: BoxFit.fill, 
                      ),
                    ),
                  ),
                )
            ],
          )
        ],
      ),
    );
  }
}
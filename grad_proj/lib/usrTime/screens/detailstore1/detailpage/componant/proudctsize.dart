import 'package:flutter/material.dart';
import 'package:grad_proj/constants.dart';

import '../../../../../login/responsive.dart';
import '../../../home/components/section_title.dart';

class ProductSize extends StatelessWidget {
  const ProductSize({Key? key, required this.Size, required this.active, required this.onTap}) : super(key: key);

  final String  Size;
  final bool active;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    if (Size.isEmpty) {
      return Container(); 
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
            color: active?kSecondaryColor:Colors.white
          ),
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Text(
              Size,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BulidSize extends StatefulWidget {
  const BulidSize({Key? key, required this.item}) : super(key: key);
  final Map<String, dynamic> item;

  @override
  _BulidSizeState createState() => _BulidSizeState();
}
String chosensize="";
class _BulidSizeState extends State<BulidSize> {
  @override
  Widget build(BuildContext context) {
    if(widget.item['Size'].length==0) {
      return Container();
    }
    
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "اختر الفئة/الموديل",
            press: () {},
            showSeeAllButton: false,
          ),
        ),
        const SizedBox(height: 25,),
        Directionality(
          textDirection: TextDirection.rtl,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.isDesktop(context) ? 4 : 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
              childAspectRatio: 3,
            ),
            itemCount: widget.item['Size'].length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ProductSize(
                  Size: widget.item['Size'][index]['size'],
                  active: chosensize == widget.item['Size'][index]['size']?true:false ,
                  onTap: () {
                    setState(() {
                      chosensize = widget.item['Size'][index]['size'];
                    });
                  },
                );
              
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:grad_proj/login/responsive.dart';
import '../../../../components/product_card.dart';
import '../../detailpage/Detailpage.dart';
import 'catcard.dart';


class Subcat extends StatefulWidget {
  const Subcat({Key? key, required this.item}) : super(key: key);
 final List? item;

  @override
  _SubcatState createState() => _SubcatState();
}

class _SubcatState extends State<Subcat> {

   

  @override
  void initState() {
    super.initState();
  }
  
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              " الاقسام",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      
      ),
      body:
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                 
                   Directionality(
                     textDirection: TextDirection.rtl,
                     child: GridView.builder(
                                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                     crossAxisCount: Responsive.isDesktop(context)?3:2, 
                                     crossAxisSpacing: 20,
                                     mainAxisSpacing: 20,
                                     childAspectRatio: Responsive.isDesktop(context)?2:1, 
                                   ),
                                   itemCount:widget.item!.length ,
                                   shrinkWrap: true,
                                   physics: NeverScrollableScrollPhysics(),
                                   itemBuilder: (context, index) {
                                   return CatCard(
                                name:widget.item![index]['categoryName'],
                                image: widget.item![index]['categoryImage'],
                                press: () {
                                   Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Productsub(item: widget.item![index]['products']),
                                    ),
                                  );
                                },
                              );
                                   },
                         ),
                   ),
                   
                  ],
                ),
              ),
           ),
    );
   }
        
  }

class Productsub extends StatefulWidget {
  const Productsub({Key? key, required this.item}) : super(key: key);
 final List? item;

  @override
  _ProductsubState createState() => _ProductsubState();
}

class _ProductsubState extends State<Productsub> {

   

  @override
  void initState() {
    super.initState();
  }
  
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              " المنتجات",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      
      ),
      body:
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                 
                   Directionality(
                     textDirection: TextDirection.rtl,
                     child: GridView.builder(
                                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                     crossAxisCount: Responsive.isDesktop(context)?3:2, 
                                     crossAxisSpacing: 20,
                                     mainAxisSpacing: 20,
                                     childAspectRatio: Responsive.isDesktop(context)?2:1, 
                                   ),
                                   itemCount:widget.item!.length ,
                                   shrinkWrap: true,
                                   physics: NeverScrollableScrollPhysics(),
                                   itemBuilder: (context, index) {
                                   return ProductCard(
                                title:widget.item![index]['Name'],
                                image: widget.item![index]['proimage'],
                                price:  widget.item![index]['price'],
                                press: () {
                                   Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Detailsproduct(item: widget.item![index]),
                                    ),
                                  );
                                },
                              );
                             },
                         ),
                   ),
                  
                  ],
                ),
              ),
           ),
    );
   }
        
  }

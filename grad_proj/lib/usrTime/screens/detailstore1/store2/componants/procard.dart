
import 'package:flutter/material.dart';

class setproductcard extends StatefulWidget {
  const setproductcard({
    Key? key,
    required this.image,
     required this.name,
    required this.desc,
    required this.price,
    required this.press,
    required this.bgColor,
  }) : super(key: key);

  final String image, name,desc;
  final VoidCallback press;
  final int price;
  final Color bgColor;

  @override
  _setproductcardState createState() => _setproductcardState();
}

class _setproductcardState extends State<setproductcard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
 
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 1.05).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GestureDetector(
          onTap: widget.press,
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(16 / 2),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: widget.bgColor,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Image.asset(
                    widget.image,
                    height: 180,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.name,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                       widget.price.toString()+"شيكل",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  widget.desc,
                  style: const TextStyle(color: Color.fromARGB(186, 0, 0, 0)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

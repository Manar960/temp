import 'package:flutter/material.dart';
import 'package:grad_proj/constants.dart';

class CatCard extends StatefulWidget {
  const CatCard({
    Key? key,
    required this.image,
    required this.name,
    required this.press,
  }) : super(key: key);
  final String image, name;
  final VoidCallback press;


  @override
  _CatCardState createState() => _CatCardState();
}

class _CatCardState extends State<CatCard>
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
    return GestureDetector(
      onTap: widget.press,
      child: MouseRegion(
        onEnter: (_) => _controller.forward(),
        onExit: (_) => _controller.reverse(),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(16 / 2),
            decoration: const BoxDecoration(
              color: bluebasic,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Image.asset(
                      widget.image,
                      height: 125,
                      width: 100,

                    ),
                  ),
                  const SizedBox(height: 16 / 2),
                Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            widget.name,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                     
                    ],
                  ),
                )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

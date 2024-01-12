import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
    required this.press,
    required this.bgColor,
  }) : super(key: key);

  final String image, title;
  final VoidCallback press;
  final int price;
  final Color bgColor;

  @override
  // ignore: library_private_types_in_public_api
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
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
                    height: 132,
                  ),
                ),
                const SizedBox(height: 16 / 2),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 16 / 4),
                    Text(
                      "${widget.price}₪",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 16 / 2),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Image.asset('assets/images/power.png',
                                  width: 30, height: 30),
                              const SizedBox(height: 8),
                              const Text('القوة'),
                              const SizedBox(height: 8),
                              const Text('1600'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            children: [
                              Image.asset('assets/images/fuel.png',
                                  width: 30, height: 30),
                              const SizedBox(height: 8),
                              const Text('الوقود'),
                              const SizedBox(height: 8),
                              const Text('ديزل'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            children: [
                              Image.asset('assets/images/hp.png',
                                  width: 30, height: 30),
                              const SizedBox(height: 8),
                              const Text('عدد الاحصنة'),
                              const SizedBox(height: 8),
                              const Text('132'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Image.asset('assets/images/distance.png',
                                  width: 30, height: 30),
                              const SizedBox(height: 8),
                              const Text('المسافة'),
                              const SizedBox(height: 8),
                              const Text('50000'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            children: [
                              Image.asset('assets/images/date.png',
                                  width: 30, height: 30),
                              const SizedBox(height: 8),
                              const Text('سنة الانتاج'),
                              const SizedBox(height: 8),
                              const Text('2021'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            children: [
                              Image.asset('assets/images/seat.png',
                                  width: 30, height: 30),
                              const SizedBox(height: 8),
                              const Text('عدد المقاعد'),
                              const SizedBox(height: 8),
                              const Text('4'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

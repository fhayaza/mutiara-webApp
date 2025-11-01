import 'package:core/core.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double begin = .16;
  double end = .16;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: begin, end: end),
          duration: const Duration(seconds: 1),
          builder: (context, value, child) => ClipRect(
            clipBehavior: Clip.antiAlias,
            clipper: DClipper(value),
            child: SizedBox(
              width: context.rsize(.8),
              child: Image.asset(Assets.images.digitelnusa),
            ),
          ).builder((parent) {
            if (end == 1) {
              return parent.animate().shimmer(duration: const Duration(seconds: 1));
            }
            return parent;
          }),
        )
            .animate(
              onComplete: (controller) {
                end = 1;
                setState(() {});
              },
            )
            .slideX(begin: .4, end: .4, duration: Duration.zero)
            .scaleXY(begin: 0, end: 1, duration: const Duration(seconds: 1), curve: Curves.bounceOut)
            .slideX(delay: const Duration(milliseconds: 1500), begin: 0, end: -.4, duration: const Duration(seconds: 1)),
      ),
    );
  }
}

class DClipper extends CustomClipper<Rect> {
  final double percentage;
  DClipper(this.percentage);
  @override
  getClip(Size size) => Rect.fromLTWH(0, 0, size.width * percentage, size.height);
  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}

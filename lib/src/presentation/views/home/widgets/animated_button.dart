import 'package:flutter/material.dart';
import 'package:puntos_colombia_short_url/config/labels.dart';
import 'package:puntos_colombia_short_url/src/utils/constants/sizes.dart';

class AnimatedButton extends StatefulWidget {
  final void Function()? onPressed;
  const AnimatedButton({super.key, required this.onPressed});

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  double height = 70;
  double width = 200;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: defaultPadding,
      duration: const Duration(milliseconds: 400),
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            height = 90;
            width = 220;
          });
          await Future.delayed(Duration(milliseconds: 200));
          setState(() {
            height = 70;
            width = 200;
          });
          if (widget.onPressed != null) {
            widget.onPressed!.call();
          }
        },
        child: Text(labels.send_url),
      ),
    );
  }
}

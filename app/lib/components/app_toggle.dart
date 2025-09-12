import 'package:flutter/material.dart';

import '../theme/app_themes.dart';

class AnimatedToggle extends StatefulWidget {
  final List<String> values;
  final ValueChanged<int> onToggleCallback;
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;
  final int initialValue;

  const AnimatedToggle({
    required this.values,
    required this.onToggleCallback,
    required this.initialValue,
    super.key,
    this.backgroundColor = const Color(0xFFe7e7e8),
    this.buttonColor = const Color(0xFFFFFFFF),
    this.textColor = const Color(0xFF000000),
  });

  @override
  AnimatedToggleState createState() => AnimatedToggleState();
}

class AnimatedToggleState extends State<AnimatedToggle> {
  bool initialPosition = true;

  @override
  void initState() {
    if (widget.initialValue == 0) {
      initialPosition = true;
    } else {
      initialPosition = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 128,
      height: 26,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.color.primary),
      ),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              initialPosition = !initialPosition;
              var index = 0;
              if (!initialPosition) {
                index = 1;
              }
              widget.onToggleCallback(index);
              setState(() {});
            },
            child: Container(
              width: 128,
              height: 26,
              decoration: ShapeDecoration(
                color: widget.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  widget.values.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      widget.values[index],
                      style: context.textStyle.bodySSemiBold.copyWith(color: context.color.gray5),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate,
            alignment: initialPosition ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: 64,
              height: 26,
              decoration: ShapeDecoration(
                color: widget.buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                initialPosition ? widget.values[0] : widget.values[1],
                style: context.textStyle.bodySSemiBold.copyWith(color: widget.textColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

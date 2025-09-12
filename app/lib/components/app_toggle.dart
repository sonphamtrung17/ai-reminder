import 'package:flutter/material.dart';

import '../theme/app_themes.dart';
import '../theme/dimens/dimens.dart';

class AppToggle extends StatefulWidget {
  final List<String> values;
  final ValueChanged<bool> onToggleCallback;
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;
  final bool initialValue;

  const AppToggle({
    required this.values,
    required this.onToggleCallback,
    required this.initialValue,
    super.key,
    this.backgroundColor = Colors.grey,
    this.buttonColor = Colors.white,
    this.textColor = Colors.black,
  });

  @override
  AppToggleState createState() => AppToggleState();
}

class AppToggleState extends State<AppToggle> {
  bool initialPosition = true;

  @override
  void initState() {
    if (widget.initialValue == false) {
      initialPosition = false;
    } else {
      initialPosition = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimens.d128,
      height: Dimens.d26,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.color.primary),
      ),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              initialPosition = !initialPosition;
              widget.onToggleCallback(initialPosition);
              setState(() {});
            },
            child: Container(
              width: Dimens.d128,
              height: Dimens.d26,
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
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.d18),
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
            alignment: !initialPosition ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: Dimens.d64,
              height: Dimens.d26,
              decoration: ShapeDecoration(
                color: widget.buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                !initialPosition ? widget.values[0] : widget.values[1],
                style: context.textStyle.bodySSemiBold.copyWith(color: widget.textColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

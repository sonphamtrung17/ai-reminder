import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class ItemContainerDateTime extends StatelessWidget {
  final bool isSelect;
  final String title;
  final Function onTap;

  const ItemContainerDateTime({
    required this.isSelect,
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap.call(),
      child: Container(
        width: 120,
        height: 36,
        decoration: BoxDecoration(
          border: isSelect ? Border.all(width: 1, color: context.color.primary) : null,
          color: context.color.gray1,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            title,
            style: context.textStyle.bodyMMedium.copyWith(
              color: isSelect ? context.color.primary : context.color.black,
            ),
          ),
        ),
      ),
    );
  }
}

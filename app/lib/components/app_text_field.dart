import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import '../theme/theme.dart';
import 'components.dart';

class AppTextField extends StatefulWidget {
  final String? errorText;
  final String? labelText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final bool? enabled;
  final bool? readOnly;

  const AppTextField({
    super.key,
    this.errorText,
    this.labelText,
    this.controller,
    this.validator,
    this.suffixIcon,
    this.enabled = true,
    this.readOnly,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    if (widget.errorText != oldWidget.errorText) {
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: context.color.white,
            borderRadius: BorderRadius.circular(Dimens.d12),
            border: Border.all(color: context.color.border),
          ),
          padding: EdgeInsets.only(
            left: Dimens.d12,
            right: widget.suffixIcon == null ? Dimens.d12 : 0,
            top: Dimens.d3,
            bottom: Dimens.d3,
          ),
          child: TextFormField(
            enabled: widget.enabled,
            readOnly: widget.readOnly ?? false,
            style: context.textStyle.bodyMMedium.copyWith(fontSize: 14),
            validator: widget.validator,
            controller: widget.controller,
            decoration: InputDecoration(
              labelText: widget.labelText,
              labelStyle: context.textStyle.bodySRegular.copyWith(
                color: context.color.gray6,
                fontSize: Dimens.d14,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              suffixIcon: widget.suffixIcon,
            ),
          ),
        ),
        Visibility(
          visible: widget.errorText != null && widget.errorText!.isNotEmpty,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Space(height: 4),
              Text(
                widget.errorText ?? '',
                style: context.textStyle.bodySRegular.copyWith(
                  color: context.color.red,
                ),
              ).wrapPadding(const EdgeInsets.only(left: Dimens.d2)),
            ],
          ),
        ),
      ],
    );
  }
}

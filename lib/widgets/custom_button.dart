import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomButton extends HookWidget {
  final Key? key;

  final double? width;
  final double? height;

  final Widget? label;
  final Color? color;

  final Function()? onTap;
  final ShapeBorder? shape;

  final Widget? icon;

  CustomButton({
    this.key,
    required this.label,
    this.width,
    this.height,
    this.color,
    this.onTap,
    this.shape,
    this.icon,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {

    return ButtonTheme(
      minWidth: width ?? 88.0,
      height: height ?? 50.0,
      child: ElevatedButton.icon(
        label: label!,
        icon: icon ?? Container(),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            )),
        onPressed: onTap,
      ),
    );
  }
}

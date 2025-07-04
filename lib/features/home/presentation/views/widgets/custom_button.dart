import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final String title;
  final Color? color;
  final void Function()? onPressed;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      onPressed: onPressed,
      child: Text(title,style: TextStyle(color: Colors.white),),
    );
  }
}

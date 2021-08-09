import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  const DefaultLayout({Key? key, required this.child, this.leading}) : super(key: key);

  final Widget child;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: new LinearGradient(colors: [
        Colors.red.shade300,
        Colors.red.shade400,
      ])),
      child: child,
    );
  }
}

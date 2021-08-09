import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/layout.theme.dart';

class FunctionalityLayout extends StatefulWidget {
  const FunctionalityLayout({
    Key? key,
    this.leading,
    this.title,
    this.action,
    required this.child,
  }) : super(key: key);

  final Widget? leading;
  final String? title;
  final List<Widget>? action;
  final Widget child;

  @override
  _FunctionalityLayoutState createState() => _FunctionalityLayoutState();
}

class _FunctionalityLayoutState extends State<FunctionalityLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: new LinearGradient(colors: [Colors.red.shade300, Colors.red.shade400])),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            brightness: Brightness.dark,
            backgroundColor: Colors.transparent,
            leading: widget.leading,
            title: Text(widget.title ?? "", style: Get.textTheme.bodyText1!.copyWith(color: Colors.white)),
            actions: widget.action,
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(padding),
                topRight: Radius.circular(padding),
              ),
              color: Colors.white,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

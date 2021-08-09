import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/color.theme.dart';

class ClickableText extends StatefulWidget {
  const ClickableText({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final Text text;
  final Function() onTap;

  @override
  _ClickableTextState createState() => _ClickableTextState();
}

class _ClickableTextState extends State<ClickableText> {
  Color _currentColor = primaryColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapCancel: () {
        setState(() {
          _currentColor = widget.text.style != null
              ? widget.text.style!.color != null
                  ? widget.text.style!.color!
                  : Get.textTheme.bodyText1!.color!
              : Get.textTheme.bodyText1!.color!;
        });
      },
      onTapDown: (details) {
        setState(() {
          _currentColor = widget.text.style != null
              ? widget.text.style!.color != null
                  ? widget.text.style!.color!.withOpacity(0.5)
                  : Get.textTheme.bodyText1!.color!.withOpacity(0.5)
              : Get.textTheme.bodyText1!.color!.withOpacity(0.5);
        });
      },
      onTapUp: (details) {
        setState(() {
          _currentColor = widget.text.style != null
              ? widget.text.style!.color != null
                  ? widget.text.style!.color!
                  : Get.textTheme.bodyText1!.color!
              : Get.textTheme.bodyText1!.color!;
        });
      },
      child: Text(
        widget.text.data!,
        style: widget.text.style != null ? widget.text.style!.copyWith(color: _currentColor) : Get.textTheme.bodyText1!.copyWith(color: _currentColor),
      ),
    );
  }
}

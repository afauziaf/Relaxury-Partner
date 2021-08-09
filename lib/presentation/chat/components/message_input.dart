import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../../../global/themes/color.theme.dart';
import '../../../global/themes/input.theme.dart';
import '../../../global/themes/layout.theme.dart';
import '../../../global/widgets/gutter.dart';

class MessageInput extends StatefulWidget {
  const MessageInput({
    Key? key,
    required this.sendButtonPressed,
  }) : super(key: key);

  final Function(String) sendButtonPressed;

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  TextEditingController _inputController = new TextEditingController();
  bool valid = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(padding),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) {
                setState(() {
                  if (_inputController.text.length > 0) {
                    valid = true;
                  } else {
                    valid = false;
                  }
                });
              },
              controller: _inputController,
              decoration: inputDecoration,
            ),
          ),
          Gutter(),
          GFIconButton(
            onPressed: valid
                ? () {
                    widget.sendButtonPressed(_inputController.text.trim());
                    _inputController.clear();
                  }
                : null,
            color: valid ? primaryColor : Colors.grey.shade200,
            icon: Icon(
              Icons.send,
              size: 20,
              color: Colors.grey.shade600,
            ),
          )
        ],
      ),
    );
  }
}

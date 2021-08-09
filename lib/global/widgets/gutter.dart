import 'package:flutter/material.dart';

import '../themes/layout.theme.dart';

class Gutter extends StatelessWidget {
  const Gutter({Key? key, this.scale}) : super(key: key);

  final double? scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: gutter * (scale ?? 1),
      width: gutter * (scale ?? 1),
    );
  }
}

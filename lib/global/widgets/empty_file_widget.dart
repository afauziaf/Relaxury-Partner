import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../themes/layout.theme.dart';

class EmptyFileWidget extends StatelessWidget {
  const EmptyFileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/empty_file.svg',
          width: 48 * 2,
          height: 48 * 2,
        ),
      ),
    );
  }
}

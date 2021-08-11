import 'package:flutter/material.dart';

import '../../../global/layouts/functionality.layout.dart';
import '../../../global/themes/color.theme.dart';
import '../../../global/themes/layout.theme.dart';
import '../../../global/widgets/gutter.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.content,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return FunctionalityLayout(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(left: padding, right: padding, top: padding, bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? (MediaQuery.of(context).viewInsets.bottom + padding) : padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title
            Text(
              title,
              style: Theme.of(context).textTheme.headline5!.copyWith(color: primaryColor, fontWeight: FontWeight.bold),
            ),

            Gutter(),

            // Subtitle
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
            ),

            Gutter(scale: 2),

            content,
          ],
        ),
      ),
    );
  }
}

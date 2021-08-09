import 'package:flutter/material.dart';

import 'layout.theme.dart';

final InputDecoration inputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.grey[200],
  contentPadding: EdgeInsets.symmetric(horizontal: gutter),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius), borderSide: BorderSide(color: Colors.grey.shade200)),
  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius), borderSide: BorderSide(color: Colors.grey.shade200)),
  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius), borderSide: BorderSide(color: Colors.red, width: 2)),
  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius), borderSide: BorderSide(color: Colors.red)),
  focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius), borderSide: BorderSide(color: Colors.red, width: 2)),
  disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius), borderSide: BorderSide(color: Colors.grey.shade200)),
);

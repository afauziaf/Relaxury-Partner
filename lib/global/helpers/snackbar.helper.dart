import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../themes/layout.theme.dart';

enum AlertType {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
}

class AlertSnackbar {
  AlertSnackbar.open({
    required String title,
    required String message,
    required AlertType status,
    SnackPosition position = SnackPosition.TOP,
    IconData icon = Icons.announcement,
    Color backgroundColor = Colors.grey,
    Color textColor = Colors.black,
  }) {
    switch (status) {
      case AlertType.danger:
        icon = Icons.not_interested;
        backgroundColor = Colors.red;
        textColor = Colors.white;
        break;
      case AlertType.info:
        icon = Icons.flag;
        backgroundColor = Colors.blueAccent;
        textColor = Colors.white;
        break;
      case AlertType.success:
        backgroundColor = Colors.green;
        icon = Icons.check_circle;
        textColor = Colors.white;
        break;
      case AlertType.warning:
        icon = Icons.report;
        backgroundColor = Colors.orange;
        textColor = Colors.black;
        break;
      default:
    }

    AlertSnackbar.close();

    Get.snackbar(
      title,
      message,
      animationDuration: Duration(milliseconds: 300),
      duration: Duration(seconds: 5),
      isDismissible: true,
      icon: Icon(
        icon,
        color: textColor,
        size: 24,
      ),
      backgroundGradient: LinearGradient(colors: [
        backgroundColor.withOpacity(0.75),
        backgroundColor.withOpacity(0.25),
      ]),
      snackPosition: position,
      backgroundColor: backgroundColor,
      colorText: textColor,
      margin: EdgeInsets.all(gutter),
      padding: EdgeInsets.all(gutter),
    );
  }

  AlertSnackbar.close() {
    if (Get.isSnackbarOpen != null && Get.isSnackbarOpen!) Get.back();
  }
}

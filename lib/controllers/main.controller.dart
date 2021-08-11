import 'package:get/get.dart';
import 'chat.controller.dart';
import 'notification.controller.dart';
import 'order.controller.dart';
import 'profile.controller.dart';
import 'wallet.controller.dart';

class MainController extends GetxController {
  WalletController walletController = Get.put(WalletController());
  NotificationController notificationController = Get.put(NotificationController());
  OrderController orderController = Get.put(OrderController());
  ChatController chatController = Get.put(ChatController());
  ProfileController profileController = Get.put(ProfileController());

  @override
  void onInit() {
    super.onInit();

    walletController.getWalletInfo();
    walletController.getTransactionList();
    notificationController.getNotificationList();
    profileController.getProfileInfo();

    update();
  }
}

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
    Get.lazyPut(() => WalletController());
    Get.lazyPut(() => NotificationController());
    Get.lazyPut(() => OrderController());
    Get.lazyPut(() => ChatController());
    Get.lazyPut(() => ProfileController());
  }
}

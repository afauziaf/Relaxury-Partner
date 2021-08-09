import 'package:get/get.dart';
import '../api/notification.api.dart';
import '../global/helpers/storage.dart';
import '../models/notification/notification.model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class NotificationController extends GetxController {
  List<NotificationModel> notificationList = [];

  late IO.Socket socket = IO.io("ws://socket.relaxury.io", <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false,
  });

  getNotificationList() async {
    Response response = await NotificationApi().getNotification();
    notificationList = List<NotificationModel>.from((response.body['data']).map((json) => NotificationModel.fromJson(json)));

    update();
  }

  @override
  void onReady() {
    super.onReady();

    socket.connect();
    socket.onConnect((data) {
      socket.emit("userid", Storage(StorageName.userId).read());

      socket.on("notify", (msg) async {
        getNotificationList();
        update();
      });
    });
  }
}

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationController());
  }
}

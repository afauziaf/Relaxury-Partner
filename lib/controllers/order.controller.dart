import 'package:get/get.dart';
import '../api/order.api.dart';
import '../models/order/order.model.dart';

class OrderController extends GetxController {
  List<OrderModel> pendingBookingOrder = [];
  List<OrderModel> activeBookingOrder = [];
  List<OrderModel> bookingHistory = [];

  getBookingOrder() async {
    Response response = await OrderApi().getBookingOrder();

    if (response.statusCode == 200) {
      List<OrderModel> data = List<OrderModel>.from((response.body['data']).map((json) => OrderModel.fromJson(json)));

      pendingBookingOrder.clear();
      activeBookingOrder.clear();
      pendingBookingOrder.clear();

      for (OrderModel order in data) {
        if (order.status == 0) {
          pendingBookingOrder.add(order);
        } else if (order.status == 1) {
          activeBookingOrder.add(order);
        }

        bookingHistory.add(order);
        bookingHistory.sort((a, b) {
          return b.dateFrom!.compareTo(a.dateFrom!);
        });
      }

      update();
    }
  }

  acceptOrder(int orderId) async {
    await OrderApi(enableLoader: true, enableNotifier: true).acceptOrder(orderId: orderId);
    getBookingOrder();
  }

  cancelOrder(int orderId) async {
    await OrderApi(enableLoader: true, enableNotifier: true).cancelOrder(orderId: orderId);
    getBookingOrder();
  }
}

class OrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderController());
  }
}

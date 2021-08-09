import 'package:get/get.dart';
import '../global/helpers/api.helper.dart';

class OrderApi extends ApiHelper {
  bool? enableLoader = false;
  bool? enableNotifier = false;

  OrderApi({
    this.enableLoader,
    this.enableNotifier,
  }) : super(
          enableLoader: enableLoader,
          enableNotifier: enableNotifier,
        );

  // Get All Booking Order
  Future<Response> getBookingOrder() async {
    return get('order/sell/all');
  }

  // Accept Booking Order
  Future<Response> acceptOrder({required int orderId}) async {
    Map body = new Map();
    body['order_id'] = orderId;

    return await post('order/sell/accept', body);
  }

  // Cancel Booking Order
  Future<Response> cancelOrder({required int orderId}) async {
    Map<String, dynamic> body = new Map<String, dynamic>();
    body['order_id'] = orderId;

    return await post('order/cancel', body);
  }
}

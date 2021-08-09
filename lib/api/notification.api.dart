import 'package:get/get.dart';
import '../global/helpers/api.helper.dart';

class NotificationApi extends ApiHelper {
  // Get Notification List
  Future<Response> getNotification() async {
    return await get('notify');
  }
}

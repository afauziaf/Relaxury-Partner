import 'package:get/get.dart';
import '../global/helpers/api.helper.dart';

class ChatApi extends ApiHelper {
  bool? enableLoader = false;
  bool? enableNotifier = false;

  ChatApi({
    this.enableLoader,
    this.enableNotifier,
  }) : super(
          enableLoader: enableLoader,
          enableNotifier: enableNotifier,
        );

  // Get Chat Room Message
  Future<Response> getChatRoomMessage({required int chatRoomId}) async {
    return await get('chat/history?room_id=$chatRoomId');
  }

  // Chat
  Future<Response> chat({required int chatRoomId, required String message}) {
    return get('chat?room_id=$chatRoomId&message=$message');
  }
}

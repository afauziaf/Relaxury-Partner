import 'package:get/get.dart';
import '../api/chat.api.dart';
import 'order.controller.dart';
import '../models/chat/chat_message.model.dart';
import '../models/chat/chat_room.model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class ChatController extends GetxController {
  List<ChatRoomModel> chatRoomList = [];
  List<ChatMessageModel> currentChatMessage = [];
  late OrderController orderController = Get.find();
  late IO.Socket socket;

  connectToChatRoom(int chatRoomId) async {
    print("Chat Socket: Connecting to Chat Room $chatRoomId");

    socket = IO.io("https://socket.relaxury.io", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });

    print("Chat Socket: Connected status: " + socket.connected.toString());

    socket.connect();
    socket.onConnect((data) {
      print("Chat Socket: Connected to Chat Room $chatRoomId");
      socket.emit("join", chatRoomId);
      getChatRoomMessage(chatRoomId);

      socket.on("room_chat." + chatRoomId.toString(), (msg) {
        print("Chat Socket: New Message from Chat Room $chatRoomId");
        getChatRoomMessage(chatRoomId);
      });
    });
  }

  getChatRoomMessage(int chatRoomId) async {
    Response response = await ChatApi(enableLoader: false).getChatRoomMessage(chatRoomId: chatRoomId);

    List<ChatMessageModel> messages = List<ChatMessageModel>.from((response.body['data']).map((json) => ChatMessageModel.fromJson(json)));

    if (messages.isNotEmpty) {
      currentChatMessage.clear();
      for (ChatMessageModel message in messages) {
        currentChatMessage.add(message);
      }

      update();
    }
  }

  chat({required int chatRoomId, required String message}) async {
    await ChatApi().chat(chatRoomId: chatRoomId, message: message);
    await getChatRoomMessage(chatRoomId);

    update();
  }
}

class ChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController());
    Get.lazyPut(() => OrderController());
  }
}

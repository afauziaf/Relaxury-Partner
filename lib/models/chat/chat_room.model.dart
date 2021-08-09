import 'chat_message.model.dart';

class ChatRoomModel {
  ChatRoomModel({
    required this.id,
    required this.partnerNickname,
    this.message,
  });

  int id;
  String partnerNickname;
  List<ChatMessageModel>? message = [];
}

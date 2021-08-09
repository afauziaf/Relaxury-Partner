class ChatMessageModel {
  ChatMessageModel({
    this.id,
    this.roomId,
    this.senderId,
    this.senderName,
    this.message,
    this.createdAt,
  });

  int? id;
  int? roomId;
  String? senderId;
  String? senderName;
  String? message;
  DateTime? createdAt;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) => ChatMessageModel(
        id: json["id"],
        roomId: json["room_id"],
        senderId: json["sender_id"],
        senderName: json["sender_name"],
        message: json["message"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "room_id": roomId,
        "sender_id": senderId,
        "sender_name": senderName,
        "message": message,
        "created_at": createdAt!.toIso8601String(),
      };
}

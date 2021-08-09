class NotificationModel {
  NotificationModel({
    required this.id,
    required this.userid,
    required this.title,
    required this.content,
    required this.status,
    required this.createdAt,
  });

  int id;
  int userid;
  String title;
  String content;
  int status;
  DateTime createdAt;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json["id"],
        userid: json["userid"],
        title: json["title"],
        content: json["content"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userid": userid,
        "title": title,
        "content": content,
        "status": status,
        "created_at": createdAt.toIso8601String(),
      };
}

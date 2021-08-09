class CommissionModel {
  CommissionModel({
    required this.id,
    required this.userid,
    required this.packageid,
    required this.status,
    required this.createdAt,
    required this.dateEnd,
  });

  int id;
  int userid;
  int packageid;
  int status;
  DateTime createdAt;
  DateTime dateEnd;

  factory CommissionModel.fromJson(Map<String, dynamic> json) => CommissionModel(
        id: json["id"],
        userid: json["userid"],
        packageid: json["packageid"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        dateEnd: DateTime.parse(json["date_end"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userid": userid,
        "packageid": packageid,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "date_end": dateEnd.toIso8601String(),
      };
}

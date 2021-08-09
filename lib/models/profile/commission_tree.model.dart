import 'dart:convert';

class CommissionTree {
  CommissionTree({
    required this.name,
    required this.isOpen,
    required this.isParent,
    required this.children,
  });

  String name;
  bool isOpen;
  bool isParent;
  List<CommissionTree> children;

  factory CommissionTree.fromJson(Map<String, dynamic> json) {
    String childJson = json["children"].toString().replaceAll('/', '');

    return CommissionTree(
      name: json["name"],
      isOpen: json["isOpen"],
      isParent: json["isParent"],
      children: List<CommissionTree>.from(jsonDecode(childJson).map((x) => CommissionTree.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "isOpen": isOpen,
        "isParent": isParent,
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
      };
}

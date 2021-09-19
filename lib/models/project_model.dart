import 'dart:convert';

Project projectFromJson(String str) => Project.fromJson(jsonDecode(str));
String projectToJson(Project data) => jsonEncode(data.toJson());

class Project {
  String? id;
  String? title;
  String? description;

  Project({this.id, this.title, this.description});

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json['id'],
        title: json['title'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
      };
}

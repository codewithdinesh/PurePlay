// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

class videoStruct {
  final String id;
  final String title;
  final String file_path;
  videoStruct({
    required this.id,
    required this.title,
    required this.file_path,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'file_path': file_path,
    };
  }

  factory videoStruct.fromMap(Map<String, dynamic> map) {
    return videoStruct(
      id: map['id'],
      title: map['title'],
      file_path: map['file_path'],
    );
  }

  String toJson() => json.encode(toMap());

  factory videoStruct.fromJson(String source) =>
      videoStruct.fromMap(json.decode(source));
}

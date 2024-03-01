import 'dart:core';

import 'creator.dart';

class Video {
  String id;
  String title;
  String description;
  int? likes;
  String videoPath;
  Creator? creator;

  Video({
    required this.id,
    required this.title,
    required this.description,
    this.likes,
    required this.videoPath,
    this.creator,
  });
}

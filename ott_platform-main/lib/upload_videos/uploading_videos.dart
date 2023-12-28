import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:ott_platform_app/global.dart';
import 'package:ott_platform_app/main.dart';
import 'package:ott_platform_app/utils/snackbar.dart';
import 'package:ott_platform_app/upload_videos/error_handlingcontent.dart';
import 'package:ott_platform_app/upload_videos/sending_video.dart';
import 'package:path/path.dart' as path;

class videoUpload {
  sendingVideo sendvideo = sendingVideo();
  var videoPath;

  selectVideo(context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      videoPath = file.path;
      print(videoPath);
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(videoPath, filename: file.name),
      });
      Dio dio = Dio();
      await dio.post(
        "http://:3000/creator/content", // Replace with your Node.js server URL
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );
    } else {
      // User canceled the picker
    }
  }
}

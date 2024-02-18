import 'dart:io';

import 'dart:convert';
import 'package:ott_platform_app/model/UserData.dart';
import 'package:ott_platform_app/services/auth_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';
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


class VideoUpload {
  var videoPath;
  late String bearerToken = '';

  VideoUpload();

  Future<void> uploadVideo() async {
    try {
      // fetching auth token from the AuthServices

      AuthServices authServices = AuthServices();

      var userToken = await authServices.getUserToken();

      print("Bearer Token from AuthServices : $userToken");

      // User data
      UserData? user = await authServices.getUser();

      // Step 1: Call "/api/v1/upload-content" with Bearer token

      final contentRequest = await http.post(
        Uri.parse("$uri/api/v1/upload-content"),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $bearerToken',
          HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
        },
        body: {
          "title": "Video Title",
          "description": "Video Description",
          "creator_id": user?.id, //
        },
      );

      final contentResponse = jsonDecode(contentRequest.body);

      final msg = contentResponse['message'];
      final content_id = contentResponse['content_id'];

      print("Content Response: $contentResponse");

      // Step 2: Call "/api/v1/upload-video/:content_id" with Bearer token
      final request = http.MultipartRequest(
        'POST',
        Uri.parse("$uri/api/v1/upload-video/$content_id"),
      );

      // Add headers
      request.headers.addAll({
        HttpHeaders.authorizationHeader: 'Bearer $userToken',
      });

      // Add video file
      request.files
          .add(await http.MultipartFile.fromPath('video_file', videoPath));

      // Send request
      final response = await request.send();

      // Check HTTP status code
      if (response.statusCode == 201 || response.statusCode == 200) {
        final videoResponse = await http.Response.fromStream(response);
        print("Video uploaded successfully: ${videoResponse.body}");
      } else {
        print("Error uploading video. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error uploading video: $e");
    }
  }

  Future<void> selectVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      videoPath = file.path!;

     print(videoPath);
      await uploadVideo();
    } else {
      // User canceled the picker
    }
  }
}
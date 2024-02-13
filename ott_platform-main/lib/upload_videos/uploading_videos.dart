import 'dart:io';
import 'dart:convert';
 import 'package:shared_preferences/shared_preferences.dart';
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

// class videoUpload {
//   sendingVideo sendvideo = sendingVideo();
//   var videoPath;

//   selectVideo(context) async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();

//     if (result != null) {
//       PlatformFile file = result.files.first;
//       videoPath = file.path;
//       print(videoPath);
//       FormData formData = FormData.fromMap({
//         "file": await MultipartFile.fromFile(videoPath, filename: file.name),
//       });
//       Dio dio = Dio();
//       await dio.post(
//         "http://10.0.2.2:3000/api/v1/upload-content", // Replace with your Node.js server URL
//         data: formData,
//         options: Options(
//           contentType: 'multipart/form-data',
//         ),
//       );
//     } else {
//       // User canceled the picker
//     }
//   }
// }
// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// // import 'package:dio/dio.dart';
// class videoUpload {
//   var videoPath;

//   Future<void> uploadVideo() async {
//     try {
//       // Step 1: Call "/api/v1/upload-content"
//       final contentResponse = await http.post(
//         Uri.parse("http://10.0.2.2:3000/api/v1/upload-content"),
//         body: {
//           "title": "Video Title",
//           "description": "Video Description",
//           "creator_id": '10', // replace with actual creator ID
//         },
//       );

//       final contentId = jsonDecode(contentResponse.body)['creator_id'];

//       // Step 2: Call "/api/v1/upload-video/:content_id"
//       final request = http.MultipartRequest(
//         'POST',
//         Uri.parse("http://10.0.2.2:3000/api/v1/upload-video/$contentId"),
//       );
//       request.files.add(await http.MultipartFile.fromPath('file', videoPath));

//       final response = await request.send();
//       final videoResponse = await http.Response.fromStream(response);

//       print("Video uploaded successfully: ${videoResponse.body}");
//     } catch (e) {
//       print("Error uploading video: $e");
//     }
//   }

//   Future<void> selectVideo() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();

//     if (result != null) {
//       PlatformFile file = result.files.first;
//       videoPath = file.path!;
//       print(videoPath);
//       await uploadVideo();
//     } else {
//       // User canceled the picker
//     }
//   }
// }
// class VideoUpload {
//   var videoPath;
  
//   VideoUpload({required bearerToken});


//   Future<void> uploadVideo() async {
//     try {
//       // Step 1: Call "/api/v1/upload-content" with Bearer token
//       final contentResponse = await http.post(
//         Uri.parse("http://10.0.2.2:3000/api/v1/upload-content"),
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $bearerToken',
//           HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
//         },
//         body: {
//           "title": "Video Title",
//           "description": "Video Description",
//           "creator_id": "9", // replace with actual creator ID
//         },
//       );

//       final contentId = jsonDecode(contentResponse.body)['creator_id'];

//       // Step 2: Call "/api/v1/upload-video/:content_id" with Bearer token
//       final request = http.MultipartRequest(
//         'POST',
//         Uri.parse("http://10.0.2.2:3000/api/v1/upload-video/$contentId"),
//       );
//       request.headers.addAll({
//         HttpHeaders.authorizationHeader: 'Bearer $bearerToken',
//       });
//       request.files.add(await http.MultipartFile.fromPath('file', videoPath));

//       final response = await request.send();
//       final videoResponse = await http.Response.fromStream(response);

//       print("Video uploaded successfully: ${videoResponse.body}");
//     } catch (e) {
//       print("Error uploading video: $e");
//     }
//   }

//   Future<void> selectVideo() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();

//     if (result != null) {
//       PlatformFile file = result.files.first;
//       videoPath = file.path!;
//       print(videoPath);
//       await uploadVideo();
//     } else {
//       // User canceled the picker
//     }
//   }
// }
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import 'package:file_picker/file_picker.dart';

class VideoUpload {
  var videoPath;
  late String bearerToken = '';

  VideoUpload();

  Future<String> generateBearerToken() async {
    try {
      final authResponse = await http.post(
        Uri.parse("http://10.0.2.2:3000/auth/v1/signin"),
        body: {
          // "username": "karthick",
          "email":"test@gmail.com",
           "password": "test",
        },
      );

     final dynamic responseData = jsonDecode(authResponse.body);
print("Auth response: $responseData");

final authToken = responseData['token'];


      if (authToken != null) {
        // Save the token to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('bearerToken', authToken);

        // Set the token in the class variable
        bearerToken = authToken;

        return authToken; // Return the generated token
      } else {
        print("Error generating bearer token: No access token in the response");
        return ''; // Handle the case where no token is generated
      }
    } catch (e) {
      print("Error generating bearer token: $e");
      return ''; // Handle the error case
    }
  }

  Future<void> uploadVideo() async {
    try {
      // Step 1: Call "/api/v1/upload-content" with Bearer token
      print("Bearer Token: $bearerToken");

final contentResponse = await http.post(
  Uri.parse("http://10.0.2.2:3000/api/v1/upload-content"),
  headers: {
    HttpHeaders.authorizationHeader: 'Bearer $bearerToken',
    HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
  },
  body: {
    "title": "Video Title",
    "description": "Video Description",
    "creator_id": '7',// replace with actual creator ID
  },
);


      const content_id = 5;


      // Step 2: Call "/api/v1/upload-video/:content_id" with Bearer token
      
  final request = http.MultipartRequest(
    'POST',
    Uri.parse("http://10.0.2.2:3000/api/v1/upload-video/$content_id"),
  );

  // Add headers
  request.headers.addAll({
    HttpHeaders.authorizationHeader: 'Bearer $bearerToken',
  });

  // Add video file
  request.files.add(await http.MultipartFile.fromPath('video_file', videoPath));

  // Send request
  final response = await request.send();

  // Check HTTP status code
 // Check HTTP status code
if (response.statusCode == 201) {
  final videoResponse = await http.Response.fromStream(response);
  print("Video uploaded successfully: ${videoResponse.body}");
} else {
  print("Error uploading video. Status code: ${response.statusCode}");
}

    }
 catch (e) {
      print("Error uploading video: $e");
    }
  }

  Future<void> selectVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      videoPath = file.path!;
      print(videoPath);

      // Check if bearer token is already generated, if not, generate it
      if (bearerToken == null || bearerToken.isEmpty) {
        bearerToken = await generateBearerToken();
      }

      await uploadVideo();
    } else {
      // User canceled the picker
    }
  }
}



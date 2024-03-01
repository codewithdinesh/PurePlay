import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ott_platform/global.dart';
import 'package:ott_platform/utils/snackbar.dart';
import 'package:ott_platform/upload_videos/error_handlingcontent.dart';
import 'package:ott_platform/upload_videos/videostruct.dart';

class sendingVideo {
  void sendVideo(
      {required BuildContext context,
      required String title,
      // ignore: non_constant_identifier_names
      required String file_path}) async {
    videoStruct video = videoStruct(id: '', title: title, file_path: file_path);
    print(title);
    print(file_path);
    http.Response res = await http.post(Uri.parse('$uri/creator/content'),
        body: video.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    // ignore: use_build_context_synchronously
    httpErrorHandlecontent(
      response: res,
      context: context,
      onSuccess: () {
        showSnackBar(
          context,
          'Video got in wait for Admins Approval',
        );
      },
    );
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ott_platform/common_widget/video.dart';
import 'package:ott_platform/global.dart';
import 'package:http/http.dart' as http;
import 'package:ott_platform/model/creator.dart';
import 'package:ott_platform/model/video.dart';

import 'services/auth_service.dart';

class VideoScreen extends StatefulWidget {
  final String videoId;

  VideoScreen({required this.videoId});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  Video video = Video(
    id: "",
    title: "",
    description: "",
    videoPath: "",
    creator: Creator(
      creatorName: "",
      creatorId: "",
    ),
  );

  AuthServices authServices = AuthServices();

  late String userToken = "";

  @override
  void initState() {
    super.initState();
    setUserToken();
    _fetchVideoDetails(widget.videoId);
  }

  Future<void> setUserToken() async {
    AuthServices authServices = AuthServices();
    String? userTokn = await authServices.getUserToken();
    setState(() {
      userToken = userTokn!;
    });
    print("User Token: $userToken");
  }

  Future<void> _fetchVideoDetails(String videoId) async {
    final request = await http.get(
      Uri.parse('$uri/api/v1/video/$videoId'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $userToken',
        HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
      },
    );
    print("request.body : ${request.body}");
    final response = jsonDecode(request.body);

    if (request.statusCode == 200 || request.statusCode == 201) {
      Video v = Video(
        id: response['content_id'].toString(),
        title: response['content_title'].toString(),
        description: response['content_description'].toString(),
        // likes: response.body['likes'],
        videoPath: response['video_url'].toString(),
        creator: Creator(
          creatorName: response['creator_username'].toString(),
          creatorId: response['creator_id'].toString(),
        ),
      );

      setState(() {
        video = v;
      });
    } else {
      throw Exception("Failed to load video details");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildVideoPlayerScreen(video),
    );
  }

  Widget _buildVideoPlayerScreen(Video videoData) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          VideoPlayerWidget(videoUrl: video.videoPath),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  video.description,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage:
                          NetworkImage("https://via.placeholder.com/150"),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      video.creator!.creatorName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.thumb_up),
                    const SizedBox(width: 4),
                    Text(2.toString()),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Implement like functionality
                      },
                      child: const Text('Like'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Add comment section here
              ],
            ),
          ),
        ],
      ),
    );
  }
}

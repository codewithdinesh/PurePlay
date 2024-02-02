import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ott_platform_app/global.dart';
import 'package:ott_platform_app/google_auth.dart';
import 'package:ott_platform_app/model/UserData.dart';
import 'package:ott_platform_app/services/auth_service.dart';
import 'package:video_player/video_player.dart';

import 'package:chewie/chewie.dart';

class VideoUploadScreen extends StatefulWidget {
  @override
  _VideoUploadScreenState createState() => _VideoUploadScreenState();
}

class _VideoUploadScreenState extends State<VideoUploadScreen> {
  // Tilte and Description controller
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // File and Video Player
  XFile? _videoFile;
  VideoPlayerController? _controller;
  ChewieController? _chewieController;
  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  bool _uploading = false;
  double _uploadProgress = 0.0;
  String _uploadStatus = '';

  int? bufferDelay;

  @override
  void initState() {
    super.initState();
  }

  // Future<void> _pickVideo() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.video,
  //     allowMultiple: false,
  //   );

  //   if (result != null) {
  //     if (kIsWeb) {
  //       // setState(() {
  //       //   _selectedVideoBytes = result.files.single.bytes;
  //       //   // final videoData = Uint8List.fromList(_selectedVideoBytes!);
  //       //   _videoController = VideoPlayerController.memory(_selectedVideoBytes);
  //       //   _videoController!.initialize().then((_) {
  //       //     setState(() {});
  //       //   });
  //       // });
  //     } else {
  //       setState(() {
  //         _selectedVideoBytes = null;
  //         _videoController =
  //             VideoPlayerController.file(File(result.files.single.path!));
  //         _videoController!.initialize().then((_) {
  //           setState(() {});
  //         });
  //       });
  //     }
  //   }
  // }

  void _pickVideo(ImageSource source) async {
    XFile? pickedFile = await ImagePicker()
        .pickVideo(source: source, maxDuration: Duration(seconds: 60));

    if (pickedFile != null) {
      await _playVideo(pickedFile);

      print("working...");

      setState(() {
        _videoFile = pickedFile;
      });
    }
  }

  Future<void> uploadVideo() async {
    try {
      if (_videoFile == null) {
        _uploadStatus = 'Please select a video first.';
        return;
      }

      setState(() {
        _uploading = true;
        _uploadProgress = 0.0;
        _uploadStatus = '';
      });

      String videoTitle = _titleController.text;
      String videoDescription = _descriptionController.text;

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
          HttpHeaders.authorizationHeader: 'Bearer $userToken',
          HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
        },
        body: {
          "title": videoTitle,
          "description": videoDescription,
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

      if (_videoFile != null && _videoFile!.path.isNotEmpty) {
        request.files.add(
            await http.MultipartFile.fromPath('video_file', _videoFile!.path));
      }

      request.files.add(await http.MultipartFile.fromBytes(
          "video", _videoFile!.readAsBytes() as List<int>));

      // Send request
      final response = await request.send();

      // Check HTTP status code
      if (response.statusCode == 201 || response.statusCode == 200) {
        final videoResponse = await http.Response.fromStream(response);

        print("Video uploaded successfully: ${videoResponse.body}");
      } else {
        print("Error uploading video. Status code: ${response.statusCode}");
      }
    } catch (error) {
      _uploadStatus = 'Error uploading video: $error';
    } finally {
      setState(() {
        _uploading = false;
      });
    }
  }

  // Video Player Init and Playing
  Future<void> _playVideo(XFile? file) async {
    if (file != null) {
      print("File Path: ${file.path}");

      late VideoPlayerController controller;

      // Video sources can be either an asset or a network resource.
      if (kIsWeb) {
        controller = VideoPlayerController.networkUrl(Uri.parse(file.path));
      } else {
        controller = VideoPlayerController.file(File(file.path));
      }

      await controller.initialize();

      _controller = controller;

      _chewieController = ChewieController(
        videoPlayerController: _controller!,
        autoPlay: true,
        looping: true,
        showControls: true,
        // autoInitialize: true,
        allowMuting: true,
        allowPlaybackSpeedChanging: true,
        showOptions: true,

        progressIndicatorDelay:
            bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,

        hideControlsTimer: const Duration(seconds: 1),
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.red,
          handleColor: Colors.red,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.lightGreen,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Upload'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                _pickVideo(ImageSource.gallery);
              },
              child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: _videoFile == null
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.video_library, size: 40),
                              SizedBox(height: 8),
                              Text('Tap to select video'),
                            ],
                          ),
                        )
                      : Expanded(
                          child: Center(
                            child: _chewieController != null &&
                                    _chewieController!.videoPlayerController
                                        .value.isInitialized
                                ? Chewie(
                                    controller: _chewieController!,
                                  )
                                : const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(),
                                      SizedBox(height: 20),
                                      Text('Loading'),
                                    ],
                                  ),
                          ),
                        )),
            ),

            // Video Title
            const SizedBox(height: 16.0),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),

            // video Description
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                await uploadVideo();
              },
              child: const Text('Upload Video'),
            ),
          ],
        ),
      ),
    );
  }
}

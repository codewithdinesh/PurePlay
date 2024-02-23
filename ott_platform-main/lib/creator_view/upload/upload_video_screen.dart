import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:ott_platform_app/common_widget/round_button.dart';
import 'package:ott_platform_app/global.dart';

import 'package:ott_platform_app/model/UserData.dart';
import 'package:ott_platform_app/model/collaborator.dart';
import 'package:ott_platform_app/services/auth_service.dart';
import 'package:video_player/video_player.dart';

import 'package:chewie/chewie.dart';

import 'dart:async';

import '../../common_widget/round_text_field.dart';
import '../../utils/snackbar.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class VideoUploadScreen extends StatefulWidget {
  const VideoUploadScreen({super.key});

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

  AuthServices authServices = AuthServices();

  // list of collaborators
  List<String> _collaborators = [];

  // list of searched collaborators
  List<Collaborator> _searchedCollaborators = [];

  var userToken;

  @override
  void initState() {
    super.initState();

    userToken = authServices.getUserToken();
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

  // Pick Video from Gallery or Camera
  void _pickVideo(ImageSource source) async {
    XFile? pickedFile = await ImagePicker()
        .pickVideo(source: source, maxDuration: const Duration(seconds: 60));

    if (pickedFile != null) {
      await _playVideo(pickedFile);

      print("working...");

      setState(() {
        _videoFile = pickedFile;
      });
    }
  }

  // Upload Video to the server
  Future<void> uploadVideo() async {
    try {
      // print("File -- ${File(_videoFile!.path).absolute.path}");
      print("File Path -- ${File(_videoFile!.path).uri}");

      if (_videoFile == null) {
        _uploadStatus = 'Please select a video first.';
        showSnackBar(context, "Please select a video first.", isError: true);
        return;
      } else if (_titleController.text.isEmpty) {
        _uploadStatus = 'Please enter a title.';
        showSnackBar(context, "Please enter a title.", isError: true);
        return;
      } else if (_descriptionController.text.isEmpty) {
        _uploadStatus = 'Please enter a description.';
        showSnackBar(context, "Please enter a description.", isError: true);
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

      if (userToken == null) {
        showSnackBar(context, "User Token is null", isError: true);
        return;
      }

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
          "creator_id": user?.id.toString(), //
        },
      );

      // print("Content Request: ${contentRequest.body}");

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

      // if (_videoFile != null && _videoFile!.path.isNotEmpty) {
      //   request.files.add(await http.MultipartFile.fromPath(
      //       'video', File(_videoFile!.path) as String));
      // }

      // Working For Web
      List<int> videoBytes = await _videoFile!.readAsBytes();
      final String? mimeType =
          lookupMimeType(_videoFile!.path, headerBytes: videoBytes);

      print("Video Type: $mimeType");

      request.files.add(http.MultipartFile.fromBytes('video_file', videoBytes,
          filename: 'video.mp4', contentType: MediaType.parse(mimeType!)));

      // Send request
      final response = await request.send();

      final totalBytes = response.contentLength ?? -1;
      int uploadedBytes = 0;

      response.stream.listen(
        (List<int> chunk) {
          uploadedBytes += chunk.length;
          setState(() {
            _uploadProgress = uploadedBytes / totalBytes;
          });
        },
        onDone: () async {
          // Check HTTP status code
          if (response.statusCode == 201 || response.statusCode == 200) {
            final videoResponse = await http.Response.fromStream(response);
            print("Video uploaded successfully: ${videoResponse.body}");
            showSnackBar(context, "Video uploaded successfully");
          } else {
            print("Error: ${response}");
            showSnackBar(context, "Error uploading video", isError: true);
          }
        },
        onError: (error) {
          print("Error uploading video: $error");
          showSnackBar(context, "Error uploading video", isError: true);
        },
        cancelOnError: true,
      );
    } catch (error) {
      print("Error uploading video: $error");

      _uploadStatus = 'Error uploading video: $error';

      showSnackBar(context, "Error uploading video", isError: true);
    } finally {
      setState(() {
        _uploading = false;
      });
    }
  }

  // Fetch collaborator list from the server based on the search query
  Future<void> fetchCollaborators(String query) async {
    final response = await http.post(
      Uri.parse('$uri/api/v1/collaborators?search=$query'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $userToken',
      },
    );

    print("Collaborators Response: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final collaborators = jsonDecode(response.body)["data"];

      print("Collaborators: $collaborators");

      setState(() {
        _searchedCollaborators = Collaborator.fromJsonList(collaborators);
      });

      print("Collaborators: $collaborators");
    } else {
      print("Error fetching collaborators: ${response.body}");
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
        aspectRatio: 16 / 9,

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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      _pickVideo(ImageSource.gallery);
                    },
                    child: Container(
                      height: 250,
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
                          : Center(
                              child: _chewieController != null &&
                                      _chewieController!.videoPlayerController
                                          .value.isInitialized
                                  ? Chewie(
                                      controller: _chewieController!,
                                    )
                                  : const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(),
                                        SizedBox(height: 20),
                                        Text('Loading'),
                                      ],
                                    ),
                            ),
                    ),
                  ),

                  // unselect video if video is selected

                  if (_videoFile != null)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _videoFile = null;
                            _controller?.dispose();
                            _chewieController?.dispose();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
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

              // search and select collaborators
              RoundTextField(
                title: 'Search Collaborator',
                hintText: 'Search Collaborator',
                onChanged: (query) async {
                  if (query.isNotEmpty) {
                    await fetchCollaborators(query);
                  }
                },
              ),

              // show searched collaborators
              if (_searchedCollaborators.isNotEmpty)
                Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: _searchedCollaborators.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_searchedCollaborators[index].username),
                        onTap: () {
                          setState(() {
                            _collaborators
                                .add(_searchedCollaborators[index].username);
                            _searchedCollaborators.clear();
                          });
                        },
                      );
                    },
                  ),
                ),

              // show selected collaborators
              if (_collaborators.isNotEmpty)
                Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: _collaborators.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_collaborators[index]),
                        trailing: GestureDetector(
                          onTap: () {
                            setState(() {
                              _collaborators.removeAt(index);
                            });
                          },
                          child: const Icon(Icons.close),
                        ),
                      );
                    },
                  ),
                ),

              // show loading if video is uploading
              // show uploading status
              if (_uploading || _uploadStatus.isNotEmpty)
                Column(
                  children: [
                    LinearProgressIndicator(value: _uploadProgress),
                    const SizedBox(height: 8),
                    Text('Uploading $_uploadProgress / 100'),
                  ],
                ),

              // Upload Video Button

              RoundButton(
                  title: "Upload video",
                  onPressed: () async {
                    await uploadVideo();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

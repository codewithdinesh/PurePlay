import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

class VideoUploadScreen extends StatefulWidget {
  @override
  _VideoUploadScreenState createState() => _VideoUploadScreenState();
}

class _VideoUploadScreenState extends State<VideoUploadScreen> {
  Uint8List? _selectedVideoBytes;
  VideoPlayerController? _videoController;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  Future<void> _pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
    );

    if (result != null) {
      if (kIsWeb) {
        // setState(() {
        //   _selectedVideoBytes = result.files.single.bytes;
        //   // final videoData = Uint8List.fromList(_selectedVideoBytes!);
        //   _videoController = VideoPlayerController.memory(_selectedVideoBytes);
        //   _videoController!.initialize().then((_) {
        //     setState(() {});
        //   });
        // });
      } else {
        setState(() {
          _selectedVideoBytes = null;
          _videoController =
              VideoPlayerController.file(File(result.files.single.path!));
          _videoController!.initialize().then((_) {
            setState(() {});
          });
        });
      }
    }
  }

  Future<void> _uploadVideo() async {
    if (_selectedVideoBytes == null) {
      // Handle case when no video is selected
      return;
    }

    // Your video upload logic here

    // Dispose of the VideoPlayerController when done
    _videoController?.dispose();
  }

  @override
  void dispose() {
    // Dispose of the VideoPlayerController when the widget is disposed
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Upload'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _pickVideo,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: _selectedVideoBytes == null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.video_library, size: 40),
                            SizedBox(height: 8),
                            Text('Tap to select video'),
                          ],
                        ),
                      )
                    : FutureBuilder(
                        future: _videoController!.initialize(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return VideoPlayer(_videoController!);
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _uploadVideo,
              child: Text('Upload Video'),
            ),
          ],
        ),
      ),
    );
  }
}

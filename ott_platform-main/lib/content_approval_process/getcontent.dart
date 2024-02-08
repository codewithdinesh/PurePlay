import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ott_platform_app/content_approval_process/displayonadminpage.dart';

class VideoListScreen extends StatefulWidget {
  List<String> videoPaths;

  Future<void> fetchVideos() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/getcontent'));//ip:3000
    if (response.statusCode == 200) {
      videoPaths = parseVideoPaths(response.body);
      // Display videos using Flutter Video Player
      // ...
    } else {
      throw Exception('Failed to load videos');
    }
  }

  List<String> parseVideoPaths(String responseBody) {
    // Parse the JSON response
    final Map<String, dynamic> data = json.decode(responseBody);

    // Extract video paths
    List<dynamic> videosaths = data['videosPaths'];

    // Convert the paths to List<String>
    List<String> videoPaths = videosaths.map((video) => video['videoStream'].toString()).toList();
    // final Map<String, dynamic> data = json.decode(responseBody);
    // List<dynamic> videosPaths = data['videosPaths'];
    // return videosPaths.map((video) => video['videoStream'].toString()).toList();
    return videoPaths;
  }

  VideoListScreen(this.videoPaths);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Video List'),
      ),
      body: ListView.builder(
        itemCount: videoPaths.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Video $index'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoPlayerScreen(videoPaths[index].toString()),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError().toString();
  }
}


// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:ott_platform_app/content_approval_process/displayonadminpage.dart';

// class VideoListScreen extends StatefulWidget {
//   const VideoListScreen({super.key});

//   @override
//   _VideoListScreenState createState() => _VideoListScreenState();
// }

// class _VideoListScreenState extends State<VideoListScreen> {
//   List<String> videoPaths = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchVideos();
//   }

//   Future<void> fetchVideos() async {
//     try {
//       final response = await http.get(Uri.parse('http://10.0.2.2:3000/getcontent'));
//       if (response.statusCode == 200) {
//         setState(() {
//           videoPaths = parseVideoPaths(response.body);
//         });
//       } else {
//         throw Exception('Failed to load videos');
//       }
//     } catch (e) {
//       print('Error fetching videos: $e');
//       // Handle the error appropriately
//     }
//   }

//   List<String> parseVideoPaths(String responseBody) {
//     final Map<String, dynamic> data = json.decode(responseBody);
//     List<dynamic> videosPaths = data['videosPaths'];
//     return videosPaths.map((video) => video['videoStream'].toString()).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Video List'),
//       ),
//       body: ListView.builder(
//         itemCount: videoPaths.length,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//             title: Text('Video $index'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => VideoPlayerScreen(videoPaths[index]),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

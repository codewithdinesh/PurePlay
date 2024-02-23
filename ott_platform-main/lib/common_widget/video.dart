//working

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  double playbackSpeed = 1.0;
  bool isMuted = false;
   bool isLiked = false;
  int likeCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..addListener(() {
        setState(() {});
      })
      ..initialize().then((value) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text("Video Player in Flutter"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: VideoPlayer(_controller),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                         "${_formatDuration(_controller.value.position)}/${_formatDuration(_controller.value.duration)}",
                      ),
            ),
           Container(
              padding: const EdgeInsets.all(8.0),
              child: VideoProgressIndicator(
                _controller,
                allowScrubbing: true,
                colors: const VideoProgressColors(
                  backgroundColor: Colors.black,
                  playedColor: Colors.redAccent,
                  bufferedColor: Colors.purple,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                      setState(() {});
                    },
                    icon: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
                  ),
                  IconButton(
                    onPressed: () {
                      _controller.seekTo(const Duration(seconds: 0));
                      setState(() {});
                    },
                    icon: const Icon(Icons.stop),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isMuted = !isMuted;
                        _controller.setVolume(isMuted ? 0.0 : 1.0);
                      });
                    },
                    icon: Icon(isMuted ? Icons.volume_off : Icons.volume_up),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        playbackSpeed = playbackSpeed == 1.0 ? 1.5 : 1.0;
                        _controller.setPlaybackSpeed(playbackSpeed);
                      });
                    },
                    icon: Text("$playbackSpeed x"),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenVideoPlayer(videoPlayerController: _controller),
                        ),
                      );
                    },
                    icon: const Icon(Icons.fullscreen),
                  ),
                ],
              ),
            ),
              Container(
                  padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Creator Name", // Replace with the actual creator name
                  style: TextStyle(color: Colors.redAccent, fontSize: 16),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                      likeCount += isLiked ? 1 : -1;
                    });
                  },
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.redAccent : Colors.grey,
                  ),
                ),
                Text(
                  likeCount.toString(),
                  style: const TextStyle(color: Colors.redAccent),
                ),
                const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        // Add functionality for comment buttons
                      },
                      icon: const Icon(Icons.comment, color: Colors.grey),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        // Add functionality for share buttons
                      },
                      icon: const Icon(Icons.share, color: Colors.grey),
                    ),
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class FullScreenVideoPlayer extends StatelessWidget {
  final VideoPlayerController videoPlayerController;

  const FullScreenVideoPlayer({Key? key, required this.videoPlayerController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: VideoPlayer(videoPlayerController),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayerWidget extends StatefulWidget {
//   final String videoUrl;

//   const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

//   @override
//   _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.videoUrl)
//       ..addListener(() {
//         setState(() {});
//       })
//       ..initialize().then((value) {
//         setState(() {});
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Video Player in Flutter"),
//         backgroundColor: Colors.redAccent,
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             AspectRatio(
//               aspectRatio: 16 / 9,
//               child: VideoPlayer(_controller),
//             ),
//             Container(
//               padding: EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   VideoProgressIndicator(
//                     _controller,
//                     allowScrubbing: true,
//                     colors: VideoProgressColors(
//                       backgroundColor: Colors.redAccent,
//                       playedColor: Colors.green,
//                       bufferedColor: Colors.purple,
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           if (_controller.value.isPlaying) {
//                             _controller.pause();
//                           } else {
//                             _controller.play();
//                           }
//                           setState(() {});
//                         },
//                         icon: Icon(
//                           _controller.value.isPlaying
//                               ? Icons.pause
//                               : Icons.play_arrow,
//                         ),
//                       ),
//                       Text(
//                          "${_formatDuration(_controller.value.position)}/${_formatDuration(_controller.value.duration)}",
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           _controller.seekTo(Duration(seconds: 0));
//                           setState(() {});
//                         },
//                         icon: Icon(Icons.stop),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           double speed = _controller.value.playbackSpeed + 0.1;
//                           if (speed <= 2.0) {
//                             _controller.setPlaybackSpeed(speed);
//                             setState(() {});
//                           }
//                         },
//                         icon: Icon(Icons.fast_forward),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           if (_controller.value.playbackSpeed > 1.0) {
//                             double speed =
//                                 _controller.value.playbackSpeed - 0.1;
//                             _controller.setPlaybackSpeed(speed);
//                             setState(() {});
//                           }
//                         },
//                         icon: Icon(Icons.fast_rewind),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => FullScreenVideoPlayer(
//                 videoController: _controller,
//               ),
//             ),
//           );
//         },
//         child: Icon(Icons.fullscreen),
//       ),
//     );
//   }

// String _formatDuration(Duration duration) {
//   String twoDigits(int n) => n.toString().padLeft(2, '0');
//   String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//   String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//   return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
// }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }

// class FullScreenVideoPlayer extends StatefulWidget {
//   final VideoPlayerController videoController;

//   const FullScreenVideoPlayer({Key? key, required this.videoController})
//       : super(key: key);

//   @override
//   _FullScreenVideoPlayerState createState() => _FullScreenVideoPlayerState();
// }

// class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = widget.videoController;
//     _controller.play();
//     _controller.setVolume(1.0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: AspectRatio(
//           aspectRatio: _controller.value.aspectRatio,
//           child: VideoPlayer(_controller),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         child: Icon(Icons.fullscreen_exit),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }

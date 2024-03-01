import 'dart:convert';
import 'dart:io';

import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/material.dart';
import 'package:ott_platform/common_widget/video.dart';
import 'package:ott_platform/content_approval_process/displayonadminpage.dart';
import 'package:ott_platform/global.dart';
import 'package:ott_platform/model/UserData.dart';
import 'package:ott_platform/model/video.dart';
import 'package:ott_platform/upload_videos/uploading_videos.dart';
import 'package:ott_platform/utils/snackbar.dart';
import 'package:ott_platform/video_player_screen.dart';
import 'package:video_player/video_player.dart';
import '../../common/color_extension.dart';
import '../../common_widget/round_text_field.dart';
import '../../model/creator.dart';
import '../../services/auth_service.dart';
import '../home/cast_details_view.dart';
import '../upload/upload_video_screen.dart';

import 'package:http/http.dart' as http;

class UploadedView extends StatefulWidget {
  const UploadedView({super.key});

  @override
  State<UploadedView> createState() => _UploadedViewState();
}

class _UploadedViewState extends State<UploadedView> {
  late final VideoUpload uploadVideo;
  TextEditingController txtSearch = TextEditingController();

  List<Video> videos = [];

  String? userToken = "";
  List searchArr = [
    {
      "name": "TV SHOWS",
      "list": ["assets/img/search_1.png"]
    },
    {
      "name": "MOVIES",
      "list": ["assets/img/search_2.png", "assets/img/search_3.png"]
    }
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    uploadVideo = VideoUpload();

    fetchVideos();
    FBroadcast.instance().register("change_mode", (value, callback) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  // fetch uploaded video by creator
  Future<void> fetchVideos() async {
    AuthServices authServices = AuthServices();

    UserData? user = await authServices.getUser();

    print('User Data: ${user?.toJson().toString()}');

    String? userId = user!.id.toString();
    String? userToken = await authServices.getUserToken();

    print("User Token $userToken");

    try {
      var headersList = {
        'Accept': '*/*',
        'Authorization': 'Bearer $userToken',
      };
      var url = Uri.parse('$uri/api/v1/videos/$userId');

      var request = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $userToken',
        },
      );

      // print("Fetch Videos1: ${request.body}");

      final response = jsonDecode(request.body);

      print("Fetch Videos: $response");

      if (request.statusCode == 200 || request.statusCode == 201) {
        for (var item in response) {
          // set data into model

          print("Item Body: ${item}");
          Video v = Video(
            id: item['content_id'].toString(),
            title: item['content_title'].toString(),
            description: item['content_description'].toString(),
            // likes: response.body['likes'],
            videoPath: item['video_url'].toString(),
            creator: Creator(
              creatorName: item['creator_username'].toString(),
              creatorId: item['creator_id'].toString(),
            ),
          );

          setState(() {
            videos.add(v);
          });
        }

        // print(response.body);

        print("Videos: $videos");
      } else {
        showSnackBar(context, "Error fetching videos", isError: true);
      }
    } catch (e) {
      print(e);
      showSnackBar(context, "Error fetching videos", isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.bg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: RoundTextField(
                  title: "",
                  controller: txtSearch,
                  hintText: "Search here...",
                  left: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Image.asset(
                      "assets/img/tab_search-2.png",
                      width: 20,
                      height: 20,
                      color: TColor.bgText,
                    ),
                  )),
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          // upload video button

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: OutlinedButton.icon(
                onPressed: () async {
                  // await uploadVideo.selectVideo();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VideoUploadScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.upload),
                label: const Text("Upload Video"),
              ),
            ),
          ),

// display title with line - uploaded videos
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text(
                  "Uploaded Videos",
                  style: TextStyle(
                    color: TColor.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    color: TColor.subtext,
                  ),
                )
              ],
            ),
          ),

          // display fetched videos

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: TColor.bg,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VideoPlayerWidget(
                                  videoUrl: "$uri${videos[index].videoPath}",
                                ),
                              ));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              color: TColor.castBG,
                              height: media.width * 0.4,
                              child: ClipRect(
                                child: Image.asset(
                                  "assets/img/search_1.png",
                                  height: media.width * 0.3,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                videos[index].title.toString(),
                                style: TextStyle(
                                  color: TColor.text,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Expanded(
          //   child: ListView.builder(
          //     padding: const EdgeInsets.symmetric(vertical: 15),
          //     itemCount: searchArr.length,
          //     itemBuilder: ((context, index) {
          //       var sObj = searchArr[index] as Map? ?? {};
          //       var sArr = sObj["list"] as List? ?? [];
          //       return Padding(
          //         padding: const EdgeInsets.symmetric(vertical: 8),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 15),
          //               child: Row(
          //                 children: [
          //                   Text(
          //                     sObj["name"].toString(),
          //                     style: TextStyle(
          //                         color: TColor.text,
          //                         fontSize: 12,
          //                         fontWeight: FontWeight.w500),
          //                   ),
          //                   const SizedBox(
          //                     width: 8,
          //                   ),
          //                   Expanded(
          //                     child: Container(
          //                       height: 1,
          //                       color: TColor.subtext,
          //                     ),
          //                   )
          //                 ],
          //               ),
          //             ),
          //             SizedBox(
          //               height: (media.width * 0.4),
          //               child: ListView.builder(
          //                   padding: const EdgeInsets.symmetric(
          //                       horizontal: 10, vertical: 10),
          //                   scrollDirection: Axis.horizontal,
          //                   itemCount: sArr.length,
          //                   itemBuilder: (context, index) {
          //                     return InkWell(
          //                       onTap: () {
          //                         // Navigator.push(
          //                         //     context,
          //                         //     MaterialPageRoute(
          //                         //         builder: (context) =>
          //                         //             const CastDetailsView()));
          //                       },
          //                       child: Container(
          //                         margin:
          //                             const EdgeInsets.symmetric(horizontal: 6),
          //                         color: TColor.castBG,
          //                         width: media.width * 0.25,
          //                         height: media.width * 0.32,
          //                         child: ClipRect(
          //                           child: Image.asset(
          //                             sArr[index].toString(),
          //                             width: media.width * 0.25,
          //                             height: media.width * 0.32,
          //                             fit: BoxFit.cover,
          //                           ),
          //                         ),
          //                       ),
          //                     );
          //                   }),
          //             ),
          //           ],
          //         ),
          //       );
          //     }),
          //   ),
          // )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ott_platform_app/common/color_extension.dart';
import 'package:ott_platform_app/creator_view/profile/profile_view.dart';
import 'package:ott_platform_app/user_view/download/download_view.dart';
import 'package:ott_platform_app/user_view/home/home_view.dart';
import 'package:ott_platform_app/user_view/profile/profile_view.dart';
import 'package:fbroadcast/fbroadcast.dart';

import '../search/uploaded_view.dart';

class CreatorMainTabView extends StatefulWidget {
  const CreatorMainTabView({super.key});

  @override
  State<CreatorMainTabView> createState() => _CreatorMainTabViewState();
}

class _CreatorMainTabViewState extends State<CreatorMainTabView>
    with TickerProviderStateMixin {
  int selectTab = 0;
  TabController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller?.addListener(() {
      selectTab = controller?.index ?? 0;
      if (mounted) {
        setState(() {});
      }
    });
    FBroadcast.instance().register("change_mode", (value, callback) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(controller: controller, children: const [
        CreatorHomeView(),
        UploadedView(),
        CreatorProfileView(),
      ]),
      backgroundColor: TColor.bg,
    /*  floatingActionButton: FloatingActionButton(
        backgroundColor: TColor.primary1,
        onPressed: () {
          TColor.tModeDark = !TColor.tModeDark;
          FBroadcast.instance().broadcast("change_mode");
          if (mounted) {
            setState(() {});
          }
        },
        child: Icon(
          TColor.tModeDark ? Icons.light_mode : Icons.dark_mode,
          color: TColor.text,
        ),
      ),*/
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color:Colors.black,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: TabBar(
              controller: controller,
              indicatorWeight: 0.01,
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              overlayColor: const MaterialStatePropertyAll(Colors.transparent),
              unselectedLabelStyle: TextStyle(
                  color: TColor.subtext,
                  fontSize: 8,
                  fontWeight: FontWeight.w700),
              labelColor: TColor.primary2,
              unselectedLabelColor: TColor.subtext,
              labelStyle: TextStyle(
                  color: TColor.primary2,
                  fontSize: 8,
                  fontWeight: FontWeight.w700),
              tabs: [
                Tab(
                  text: "HOME",
                  icon: Icon(
                    Icons.home_outlined
                  )
                ),
                Tab(
                  text: "Upload",
                  icon: Icon(
                    Icons.upload
                  ),
                ),
                Tab(
                  text: "PROFILE",
                  icon: Icon(
                    Icons.account_circle
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

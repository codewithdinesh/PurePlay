import 'package:flutter/material.dart';

import 'package:fbroadcast/fbroadcast.dart';

import '../../common/color_extension.dart';
import 'adminprofile.dart';
import 'notification_screen.dart';

//import '../search/uploaded_view.dart';

class AdminMainTabView extends StatefulWidget {
  const AdminMainTabView({super.key});

  @override
  State<AdminMainTabView> createState() => _AdminMainTabViewState();
}

class _AdminMainTabViewState extends State<AdminMainTabView>
    with TickerProviderStateMixin {
  int selectTab = 0;
  TabController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 4, vsync: this);
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
        notificationScreen(),
        // UploadedView(),
        AdminProfileView(),
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
          color: Colors.black,
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
                    text: "Notification",
                    icon: Icon(Icons.notifications_outlined)),
                /* Tab(
                  text: "Upload",
                  icon: Icon(
                    Icons.upload
                  ),
                ),*/
                Tab(
                  text: "PROFILE",
                  icon: Icon(Icons.account_circle),
                ),
              ]),
        ),
      ),
    );
  }
}

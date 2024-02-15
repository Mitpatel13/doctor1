
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vidhya_doctors/view/screens/payment/accountAdd.dart';
import 'package:vidhya_doctors/view/screens/payment/payment.dart';
import '../../controller/TextController.dart';
import '../../networkhandler.dart';
import '../Utils/colors.dart';
import '../widgets/Custom_tab_bar.dart';
import '../widgets/ProfileAvatar.dart';
import '../widgets/big_text.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ManageAccount/profile.dart';
import 'booking/booking.dart';
import 'booking/consulting.dart';
import 'dailySlot/DailySlots.dart';
import 'loginPage.dart';
import 'mainPages/Homescreen.dart';
import 'mainPages/ReferAndEarn.dart';
import 'mainPages/subscription.dart';

class navScreen extends StatefulWidget {
  navScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<navScreen> createState() => _navScreenState();
}

class _navScreenState extends State<navScreen> {
  NetworkHandler networkHandler = NetworkHandler();
  GetStorage box = GetStorage();
  final TextController textcont = Get.find<TextController>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final List<Widget> _screen = [
    HomeScreen(),
    // MyBookings(),
    Bookings(),
    const Profile(),
    HomeScreen(),
  ];
  final List<IconData> _icons = [
    Icons.home,
    MdiIcons.calendar,
    MdiIcons.account,
    Icons.menu,
  ];
  final List<String> _text = const [
    "Home",
    "Appointmnets",
    "profile",
    "Menu",
  ];
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _icons.length,
        child: Scaffold(
          key: _scaffoldKey,
          endDrawer: openEndDrawer(),
          // endDrawerEnableOpenDragGesture: true,
          body: IndexedStack(
            index: selectedIndex,
            children: _screen,
          ),
          bottomNavigationBar: CustomTabBar(
            items: _text,
            icons: _icons,
            // isBottomIndicator: true,
            selectedIndex: selectedIndex,
            onTap: (index) => index == 3
                ?
                // _scaffoldKey.currentState!.openEndDrawer()
                setState(() {
                    _scaffoldKey.currentState!.openEndDrawer();
                    selectedIndex = 0;
                  })
                : index == 0
                    ? setState(() {
                        textcont.pagenumber.value = 0;
                        selectedIndex = index;
                      })
                    : setState(() {
                        selectedIndex = index;
                      }),
          ),
        ));
  }

  Widget openEndDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                // CircleAvatar(
                //   child: ClipOval(
                //     child: Image.asset(
                //       'assets/logo.png',
                //       width: 100,
                //       height: 100,
                //       fit: BoxFit.fill,
                //     ),
                //   ),
                //   radius: 40,
                //   backgroundColor: Colors.grey[200],
                //   //  backgroundImage: AssetImage("assets/doctor.jpeg"),
                // ),
                ProfileAvatar(id: textcont.userid.toString(), imagesize: 50),
                BigText(
                  text: textcont.name.toString(),
                  color: Colors.white,
                )
              ],
            ),
            decoration: BoxDecoration(
              color: AppColors.mainColor,
            ),
          ),
          ListTile(
            title: Text('Daily Slot'),
            onTap: () {
              Get.back();
              Get.to(DailySlot());
            },
          ),
          ListTile(
            title: Text('Consulting'),
            onTap: () {
              Get.back();
              Get.to(Consulting());
            },
          ),
          ListTile(
            title: Text('Payment'),
            onTap: () async {
              var response = await networkHandler.get("/CheckPaymentAccount");

              if (response == "Activated") {
                // Get.snackbar("Error", "Error to load. please try later");
                Get.back();
                Get.to(Payment());
              } else if (response == "NotActivated") {
                // Get.snackbar("Error", "Error to load. please try later");
                Get.back();
                Get.to(AccountAdd());
              } else {
                Get.snackbar("Error", "Error to load. please try later");
              }
            },
          ),
          // ListTile(
          //   title: Text('Change Password'),
          //   onTap: () {
          //     Get.back();
          //     Get.to(ChangePassword());
          //   },
          // ),
          ListTile(
            title: Text('Refer and Earn'),
            onTap: () {
              Get.back();
              Get.to(ReferAndEarn());
            },
          ),
          ListTile(
            title: Text('Subscription'),
            onTap: () {
              Get.back();
              Get.to(Subscription());
            },
          ),
          ListTile(
            title: Text('About'),
            onTap: () {
              _launchURL() async {
                var url = "https://vaidhya421.herokuapp.com";
                if (await launch(url)) {
                  await canLaunch(url);
                } else {
                  throw 'Could not launch $url';
                }
              }
            },
          ),
          ListTile(
            title: Text('Sign out'),
            onTap: () {
              box.remove("token");
              Get.offAll(()=>LoginPage());
            },
          ),
        ],
      ),
    );
  }
}

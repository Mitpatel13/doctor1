import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidhya_doctors/view/screens/ManageAccount/profileEditScreen.dart';
import '../../../controller/ReviewController.dart';
import '../../../controller/TextController.dart';
import '../../../model/reviewModel.dart';
import '../../../model/userModel.dart';
import '../../../networkhandler.dart';
import '../../Utils/Utiils.dart';
import '../../widgets/big_text.dart';
import '../../widgets/doctorProfile.dart';
import '../../widgets/editicon.dart';
import '../../widgets/small_text.dart';
import '../../widgets/widgets.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
   TextController textController = Get.find<TextController>();
  ReviewController reviewController = Get.find<ReviewController>();
  NetworkHandler networkHandler = NetworkHandler();
  UserModel? user;
  @override
  void initState() {
    super.initState();
    fetchprofile();
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Container(
            color: Colors.transparent,
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        }));
  }

  void fetchprofile() async {
    var response = await networkHandler.get("/dashboard");
    Get.back();
    setState(() {
      user = UserModel.fromJson(response["data"][0]);

      textController.userid.value = user!.id;
      textController.name.value = user!.name;
      textController.phone.value = user!.phone;
      textController.latitude.value = user!.location.coordinates[0].toString();
      textController.lontitude.value = user!.location.coordinates[1].toString();
      textController.address.value = user!.address;
      textController.qualification.value = user!.qualifications;
      textController.experience.value = user!.experience;
      textController.refCode.value = user!.referid;
      textController.subEndDate.value = user!.subEnddate;
      textController.regNo.value = user!.regNumber;
      textController.rating.value = user!.rating != 0
          ? ((user!.rating / user!.totalRating) * 100).toInt().toString()
          : "0";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: BigText(
            text: "My Profile",
            color: Colors.white,
            size: 17,
            weight: FontWeight.w300,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              user?.name != null
                  ? Stack(
                      children: [
                        Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                                onTap: (() {
                                  Get.to(ProfileEditScreen(
                                    id: user!.id,
                                    name: user!.name,
                                    department: user!.specality,
                                    address: user!.address,
                                    qualification: user!.qualifications,
                                    experience: user!.experience,
                                  ));
                                }),
                                child: EditIcon())),
                        DoctorProfile(
                          id: user!.id,
                          name: user!.name,
                          department: user!.specality,
                          address: user!.address,
                          qualification: user!.qualifications,
                          experience: user!.experience,
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
              Divider(
                thickness: 2,
                color: AppColors.mainColor,
              ),
              GestureDetector(
                onTap: () async {
                  if (reviewController.count == 0) {
                    var response = await networkHandler.get("/displayReviews");
                    if (response != null) {
                      reviewController.reviewList.value =
                          List<ReviewModel>.from(
                              response.map((x) => ReviewModel.fromJson(x)));
                    }
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.comment,
                      size: 30,
                      color: AppColors.secondColor,
                    ),
                    SmallText(
                      text: "Reviews",
                      size: 13,
                      color: AppColors.secondColor,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Divider(),
              GetX<ReviewController>(builder: (controller) {
                return Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  direction: Axis.horizontal,
                  children: controller.reviewList
                      .map((i) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SmallText(
                                text: i.name,
                                size: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                              SmallText(
                                text: i.comment,
                                size: 10.5,
                                color: Color.fromARGB(255, 119, 119, 119),
                                fontWeight: FontWeight.w400,
                                maxlines: 3,
                              ),
                              Divider()
                            ],
                          ))
                      .toList(),
                );
              }),
            ]),
          ),
        ));
  }
}

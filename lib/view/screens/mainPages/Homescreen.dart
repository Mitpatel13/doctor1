import 'package:flutter/material.dart';

import '../../Utils/Utiils.dart';
import '../../widgets/banners.dart';
import '../../widgets/big_text.dart';

class HomeScreen extends StatelessWidget {
  // final textcont = Get.put(TextController());
  // List<Widget> pages = [
  //   SelectPatient(),
  //   Treattype(),
  //   AppointmentType(),
  //   Categories(),
  //   DoctorsList(),
  //   SelectAppointment(),
  //   PaymentSummary(),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: BigText(
            text: "DashBoard",
            color: Colors.white,
            size: 17,
            weight: FontWeight.w300,
          ),
          centerTitle: true,
        ),
        body: Banners());
  }
}

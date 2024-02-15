import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../controller/DailySlotController.dart';
import '../../../model/slotModel.dart';
import '../../../model/slotModelList.dart';
import '../../../networkhandler.dart';
import '../../Utils/Utiils.dart';
import '../../widgets/big_text.dart';
import '../../widgets/dailyslotwidget.dart';
import '../booking/consulting.dart';
import 'dailySlotBottomSheet.dart';

class DailySlot extends StatelessWidget {
  final DailySlotController bookedSlotController = Get.find<DailySlotController>();
  DailySlot({super.key});
  SlotModelList slotlist = SlotModelList();
  late List<SlotModel> slotlistdata;
  final TextEditingController _dateController = TextEditingController();
  NetworkHandler networkHandler = NetworkHandler();
  void fetchBookings() async {
    var response = await networkHandler.get("/findalldailyAppointments");
    slotlist = SlotModelList.fromJson({'data': response["data"]});
    // print(slotlist.data);
    bookedSlotController.dailybookedList.value = slotlist.data!;
    // slotController.bookedList.value = [];
  }

  DateTime? pickedDate = DateTime.now();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    fetchBookings();
    return Scaffold(
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) => DailySlotBottomSheet())
          },
          child: Icon(
            Icons.add,
            size: 25,
          ),
        ),
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: BigText(
            text: "Daily Slot",
            color: Colors.white,
            size: 17,
            weight: FontWeight.w300,
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: IconButton(
                  color: AppColors.mainColor,
                  onPressed: () {
                    Get.to(Consulting());
                  },
                  icon: Icon(
                    MdiIcons.cashMultiple,
                    color: Colors.white,
                    size: 25,
                  )),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              GetX<DailySlotController>(builder: (controller) {
                return Center(
                  child: Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    direction: Axis.horizontal,
                    children: controller.dailybookedList
                        .map((i) => DailySlotWidget(slot: i))
                        .toList(),
                  ),
                );
              }),
              SizedBox(
                height: 70,
              )
            ]),
          ),
        ));
  }
}

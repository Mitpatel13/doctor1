import 'package:json_annotation/json_annotation.dart';
part 'bookedSlotModel.g.dart';

@JsonSerializable()
class BookedSlotModel {
  String time;
  String date;
  int treattype;
  String patientname;
  String patientid;
  String phone;
  String status;
  int fees;
  bool summary;
  BookedSlotModel(
      {required this.time,
      required this.date,
      required this.treattype,
      required this.patientid,
      required this.patientname,
      required this.phone,
      required this.fees,
      required this.status,
      required this.summary});
  factory BookedSlotModel.fromJson(Map<String, dynamic> json) =>
      _$BookedSlotModelFromJson(json);
  Map<String, dynamic> toJson() => _$BookedSlotModelToJson(this);
}

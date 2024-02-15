import 'package:json_annotation/json_annotation.dart';
part 'slotModel.g.dart';

@JsonSerializable()
class SlotModel {
  String time;
  int treattype;
  SlotModel({
    required this.time,
    required this.treattype,
  });
  factory SlotModel.fromJson(Map<String, dynamic> json) =>
      _$SlotModelFromJson(json);
  Map<String, dynamic> toJson() => _$SlotModelToJson(this);
}

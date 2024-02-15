import 'package:json_annotation/json_annotation.dart';
import './slotModel.dart';
part 'slotModelList.g.dart';

@JsonSerializable()
class SlotModelList {
  List<SlotModel>? data;
  SlotModelList({this.data});
  factory SlotModelList.fromJson(Map<String, dynamic> json) =>
      _$SlotModelListFromJson(json);
  Map<String, dynamic> toJson() => _$SlotModelListToJson(this);
}

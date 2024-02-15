import 'package:json_annotation/json_annotation.dart';
import 'bookedSlotModel.dart';
part 'bookedSlotListModel.g.dart';

@JsonSerializable()
class BookedSlotListModel {
  List<BookedSlotModel>? data;
  BookedSlotListModel({this.data});
  factory BookedSlotListModel.fromJson(Map<String, dynamic> json) =>
      _$BookedSlotListModelFromJson(json);
  Map<String, dynamic> toJson() => _$BookedSlotListModelToJson(this);
}

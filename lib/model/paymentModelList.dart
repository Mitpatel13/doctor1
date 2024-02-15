import 'package:json_annotation/json_annotation.dart';
import 'package:vidhya_doctors/model/paymentModel.dart';
part 'paymentModelList.g.dart';

@JsonSerializable()
class PaymentModelList {
  List<PaymentModel>? data;
  PaymentModelList({this.data});
  factory PaymentModelList.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelListFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentModelListToJson(this);
}

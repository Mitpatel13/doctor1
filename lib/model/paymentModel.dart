import 'package:json_annotation/json_annotation.dart';
part 'paymentModel.g.dart';

@JsonSerializable()
class PaymentModel {
  DateTime date;
  int amount;
  DateTime? payDate;
  String status;
  PaymentModel({
    required this.date,
    required this.amount,
    this.payDate,
    required this.status,
  });
  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}

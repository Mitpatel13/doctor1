// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymentModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) => PaymentModel(
      date: DateTime.parse(json['date'] as String),
      amount: json['amount'] as int,
      payDate: json['payDate'] == null
          ? null
          : DateTime.parse(json['payDate'] as String),
      status: json['status'] as String,
    );

Map<String, dynamic> _$PaymentModelToJson(PaymentModel instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'amount': instance.amount,
      'payDate': instance.payDate?.toIso8601String(),
      'status': instance.status,
    };

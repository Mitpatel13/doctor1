// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymentModelList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentModelList _$PaymentModelListFromJson(Map<String, dynamic> json) =>
    PaymentModelList(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PaymentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentModelListToJson(PaymentModelList instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slotModelList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlotModelList _$SlotModelListFromJson(Map<String, dynamic> json) =>
    SlotModelList(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SlotModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SlotModelListToJson(SlotModelList instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

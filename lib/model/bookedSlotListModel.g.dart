// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookedSlotListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookedSlotListModel _$BookedSlotListModelFromJson(Map<String, dynamic> json) =>
    BookedSlotListModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BookedSlotModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookedSlotListModelToJson(
        BookedSlotListModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

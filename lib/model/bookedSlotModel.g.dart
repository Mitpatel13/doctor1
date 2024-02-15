// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookedSlotModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookedSlotModel _$BookedSlotModelFromJson(Map<String, dynamic> json) =>
    BookedSlotModel(
      date: json['date'] as String,
      time: json['time'] as String,
      treattype: json['treattype'] as int,
      patientid: json['patientid'] as String,
      patientname: json['patientname'] as String,
      phone: json['phone'] as String,
      fees: json['fees'] as int,
      status: json['status'] as String,
      summary: json['summary'] as bool,
    );

Map<String, dynamic> _$BookedSlotModelToJson(BookedSlotModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'time': instance.time,
      'treattype': instance.treattype,
      'patientname': instance.patientname,
      'patientid': instance.patientid,
      'phone': instance.phone,
      'status': instance.status,
      'fees': instance.fees,
      'summary': instance.summary,
    };

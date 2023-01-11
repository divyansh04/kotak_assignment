// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_rate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeRateModel _$ExchangeRateModelFromJson(Map<String, dynamic> json) =>
    ExchangeRateModel(
      base: json['base'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      rates: (json['rates'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      success: json['success'] as bool?,
      timestamp: json['timestamp'] as int?,
    );

Map<String, dynamic> _$ExchangeRateModelToJson(ExchangeRateModel instance) =>
    <String, dynamic>{
      'base': instance.base,
      'date': instance.date?.toIso8601String(),
      'rates': instance.rates,
      'success': instance.success,
      'timestamp': instance.timestamp,
    };

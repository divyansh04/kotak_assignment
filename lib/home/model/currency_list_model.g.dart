// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyListModel _$CurrencyListModelFromJson(Map<String, dynamic> json) =>
    CurrencyListModel(
      success: json['success'] as bool?,
      symbols: (json['symbols'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$CurrencyListModelToJson(CurrencyListModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'symbols': instance.symbols,
    };

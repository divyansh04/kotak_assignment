import 'package:json_annotation/json_annotation.dart';

part 'exchange_rate_model.g.dart';

@JsonSerializable()
class ExchangeRateModel {
  String? base;
  DateTime? date;
  Map<String, double>? rates;
  bool? success;
  int? timestamp;

  ExchangeRateModel(
      {this.base, this.date, this.rates, this.success, this.timestamp});

  factory ExchangeRateModel.fromJson(Map<String, dynamic> json) =>
      _$ExchangeRateModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeRateModelToJson(this);
}

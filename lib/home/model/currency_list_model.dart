import 'package:json_annotation/json_annotation.dart';

part 'currency_list_model.g.dart';

@JsonSerializable()
class CurrencyListModel {
  bool? success;
  Map<String, String>? symbols;

  CurrencyListModel({this.success, this.symbols});

  factory CurrencyListModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyListModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyListModelToJson(this);
}

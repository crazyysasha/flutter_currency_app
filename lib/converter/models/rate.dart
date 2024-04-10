import 'package:freezed_annotation/freezed_annotation.dart';

part 'rate.freezed.dart';
part 'rate.g.dart';

@Freezed(toJson: false)
class Rate with _$Rate {
  const factory Rate({required final String code, required final double rate}) =
      _Rate;

  factory Rate.fromJson(Map<String, dynamic> json) => _$RateFromJson(json);
}

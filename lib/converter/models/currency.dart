import 'package:freezed_annotation/freezed_annotation.dart';

import 'rate.dart';

part 'currency.freezed.dart';
part 'currency.g.dart';

@Freezed(toJson: false)
class Currency with _$Currency {
  const factory Currency({
    @JsonKey(
      name: "base_code",
    )
    required final String code,
    @JsonKey(
      name: "conversion_rates",
      fromJson: Currency.rateFromJson,
    )
    required final List<Rate> rates,
  }) = _Currency;

  static List<Rate> rateFromJson(Map<String, dynamic> json) => json.entries
      .map(
        (entry) => Rate(
          code: entry.key,
          rate: (entry.value as num).toDouble(),
        ),
      )
      .toList();

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);
}

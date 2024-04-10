import 'dart:convert';

import 'package:flutter_currency_app/converter/models/currency.dart';
import 'package:http/http.dart' as http;

class RatesRepository {
  getCurrency(String code) async {
    final http.Response response = await http.get(
      Uri.parse(
          "https://v6.exchangerate-api.com/v6/fcbc015d24865bdfd8dc6b77/latest/$code"),
    );

    return Currency.fromJson(jsonDecode(response.body));
  }
}

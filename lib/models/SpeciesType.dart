import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SpeciesType {
  final String name_ch;

  SpeciesType({
    @required this.name_ch,
  });

  factory SpeciesType.fromJson(Map<String, dynamic> json) {
    return SpeciesType(
      name_ch: json['name_ch'] as String,
    );
  }
}

List<SpeciesType> parseSpeciesType(String responseBody) {
  final parsed = convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<SpeciesType>((json) => SpeciesType.fromJson(json)).toList();
}

Future<List> fetchSpeciesType(pattern) async {
  final response = await http.get(Uri.parse('https://ar3s.dev/travel_taiwan/api/v1/species/type?keyword='+pattern));

  return parseSpeciesType(response.body);
}
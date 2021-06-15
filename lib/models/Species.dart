import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Species {
  final int marker_id;
  final String name_sci;
  final String name_ch;
  final double Longitude;
  final double Latitude;
  final String Location;

  Species({
    @required this.marker_id,
    @required this.name_sci,
    @required this.name_ch,
    @required this.Longitude,
    @required this.Latitude,
    @required this.Location,
  });

  factory Species.fromJson(Map<String, dynamic> json) {
    return Species(
      marker_id: json['marker_id'] as int,
      name_sci: json['name_sci'] as String,
      name_ch: json['name_ch'] as String,
      Longitude: json['Longitude'].toDouble(),
      Latitude: json['Latitude'].toDouble(),
      Location: json['Location'] as String,
    );
  }
}

List<Species> parseSpecies(String responseBody) {
  final parsed = convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Species>((json) => Species.fromJson(json)).toList();
}

Future<List> fetchSpecies(pattern) async {
  final response = await http.get(Uri.parse('https://ar3s.dev/travel_taiwan/api/v1/species?name_ch='+pattern));

  return parseSpecies(response.body);
}

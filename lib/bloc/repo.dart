import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../model.dart';

class AdRepository {
  Future<AdResponse> fetchAds() async {
    final response = await http.get(Uri.parse(
        "https://site.webcreationcanada.com/ds/api/get-ads-by-placement"));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      log(jsonResponse.toString());
      return AdResponse.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load ads');
    }
  }
}

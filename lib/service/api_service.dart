import 'dart:convert';

import 'package:dekontaminasi/config/config.dart';
import 'package:dekontaminasi/model/hospital.dart';
import 'package:dekontaminasi/model/news.dart';
import 'package:dekontaminasi/model/stats.dart';
import 'package:http/http.dart' as http;

class ApiService{

  Future<Status> getStatus() async {
    var url = Uri.parse('${baseURL}stats');
    print(url);

    var response = await http.get(url);
    print(response.body);

    if (response.statusCode == 200) {
      return statusFromJson(response.body);
    } else {
      throw Exception('Failed to load status data');
    }
  }

  Future<List<Hospital>?> getHospital() async {
    var url = Uri.parse('${baseURL}hospitals');
    print(url);

    var response = await http.get(url);
    print(response.body);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((hospital) =>
          Hospital.fromJson(hospital)).toList();
    } else {
      print('Request Gagal dengan status: ${response.statusCode}.');
      return null;
    }
  }

  // news
  Future<List<News>?> getNews() async {
    var url = Uri.parse('${baseURL}news');
    print(url);

    var response = await http.get(url);
    print(response.body);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((news) =>
          News.fromJson(news)).toList();
    } else {
      print('Request Gagal dengan status: ${response.statusCode}.');
      return null;
    }
  }
}
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'dart:io';

import '../model/model.dart';

class HttpServices {
  loadData({required String lat, required String lon}) async {
    String url =
        "https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lon&zoom=18&addressdetails=10";
    var pathUrl = Uri.parse(url);
    try {
      var response = await http.get(
        pathUrl,
      );
      log("dataaaaaaaa${response.body}");
      log("${response.statusCode}");
      if (response.statusCode == 200) {
        String responseString = response.body;
        if (responseString.contains("error")) {
          return false;
        }
        Model data = modelFromJson(responseString);
        return data;
      }
    } on SocketException {
      return "Network Error";
    } catch (e) {
      return e;
    }
  }
}

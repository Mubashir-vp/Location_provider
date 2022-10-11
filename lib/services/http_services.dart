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
      if (response.statusCode == 200) {
        String responseString = response.body;
        log(responseString);
        if (responseString.contains("error")) {
          log("error state");
          return false;
        } else {
          Model data = modelFromJson(responseString);
          return data;
        }
      } else if (response.statusCode == 400) {
        return false;
      }
    } on SocketException {
      return "Network Error";
    } catch (e) {
      return e;
    }
  }
}

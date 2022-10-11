import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:workshop/model/hivemodel.dart';

class HiveServices {
  Box hivebox = Hive.box<HiveModel>("location");
  savedatatobox({required HiveModel data}) {
    log("SavingData${data.displayname}");
    hivebox.add(data);
  }

  loadData() {
    List<int> keys = hivebox.keys.cast<int>().toList();
    if (keys.isEmpty) {
      return "empty";
    } else {
      return keys;
    }
  }
}

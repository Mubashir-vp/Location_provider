import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';

part 'hivemodel.g.dart';


@HiveType(typeId: 0)
class HiveModel {
  @HiveField(0)
  final String displayname;
  @HiveField(1)
  final String lat;
  @HiveField(2)
  final String lon;
  @HiveField(3)
  final String hamlet;
  @HiveField(4)
  final String iso;

  HiveModel({
    required this.displayname,
    required this.lat,
    required this.lon,
    required this.hamlet,
    required this.iso,
  });
}

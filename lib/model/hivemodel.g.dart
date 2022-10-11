// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hivemodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveModelAdapter extends TypeAdapter<HiveModel> {
  @override
  final int typeId = 0;

  @override
  HiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveModel(
      displayname: fields[0] as String,
      lat: fields[1] as String,
      lon: fields[2] as String,
      hamlet: fields[3] as String,
      iso: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.displayname)
      ..writeByte(1)
      ..write(obj.lat)
      ..writeByte(2)
      ..write(obj.lon)
      ..writeByte(3)
      ..write(obj.hamlet)
      ..writeByte(4)
      ..write(obj.iso);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

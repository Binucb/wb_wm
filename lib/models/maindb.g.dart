// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maindb.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MainDBAdapter extends TypeAdapter<MainDB> {
  @override
  final int typeId = 0;

  @override
  MainDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MainDB(
      itemDetails: (fields[0] as List?)?.cast<String>(),
    )..rwNm = fields[1] as int;
  }

  @override
  void write(BinaryWriter writer, MainDB obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.itemDetails)
      ..writeByte(1)
      ..write(obj.rwNm);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pt.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PtDBAdapter extends TypeAdapter<PtDB> {
  @override
  final int typeId = 1;

  @override
  PtDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PtDB(
      required: fields[0] as String?,
      optional: fields[1] as String?,
      conditional: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PtDB obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.required)
      ..writeByte(1)
      ..write(obj.optional)
      ..writeByte(2)
      ..write(obj.conditional);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PtDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

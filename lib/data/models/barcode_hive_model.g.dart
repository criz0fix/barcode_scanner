// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BarcodeHiveModelAdapter extends TypeAdapter<BarcodeHiveModel> {
  @override
  final int typeId = 0;

  @override
  BarcodeHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BarcodeHiveModel(
      barcode: fields[0] as String,
      creationTime: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, BarcodeHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.barcode)
      ..writeByte(1)
      ..write(obj.creationTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarcodeHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

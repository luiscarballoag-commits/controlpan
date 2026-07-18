// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'production.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductionAdapter extends TypeAdapter<Production> {
  @override
  final int typeId = 6;

  @override
  Production read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Production(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      recipeId: fields[2] as String,
      recipeName: fields[3] as String,
      lots: fields[4] as int,
      totalMassKg: fields[5] as double,
      pieceWeightGrams: fields[6] as double,
      totalPieces: fields[7] as int,
      notes: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Production obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.recipeId)
      ..writeByte(3)
      ..write(obj.recipeName)
      ..writeByte(4)
      ..write(obj.lots)
      ..writeByte(5)
      ..write(obj.totalMassKg)
      ..writeByte(6)
      ..write(obj.pieceWeightGrams)
      ..writeByte(7)
      ..write(obj.totalPieces)
      ..writeByte(8)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

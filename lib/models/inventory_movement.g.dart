// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_movement.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InventoryMovementAdapter extends TypeAdapter<InventoryMovement> {
  @override
  final int typeId = 3;

  @override
  InventoryMovement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InventoryMovement(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      type: fields[2] as String,
      ingredient: fields[3] as String,
      quantity: fields[4] as double,
      unit: fields[5] as String,
      reason: fields[6] as String,
      notes: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, InventoryMovement obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.ingredient)
      ..writeByte(4)
      ..write(obj.quantity)
      ..writeByte(5)
      ..write(obj.unit)
      ..writeByte(6)
      ..write(obj.reason)
      ..writeByte(7)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InventoryMovementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

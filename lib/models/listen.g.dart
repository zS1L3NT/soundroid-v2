// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listen.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListenAdapter extends TypeAdapter<Listen> {
  @override
  final int typeId = 2;

  @override
  Listen read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Listen()
      ..trackId = fields[0] as String
      ..userId = fields[1] as String
      ..startTime = fields[2] as String
      ..endTime = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, Listen obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.trackId)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(3)
      ..write(obj.endTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

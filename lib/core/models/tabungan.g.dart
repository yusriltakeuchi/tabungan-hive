// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tabungan.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TabunganAdapter extends TypeAdapter<Tabungan> {
  @override
  Tabungan read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tabungan(
      fields[0] as String,
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Tabungan obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.nominal);
  }
}

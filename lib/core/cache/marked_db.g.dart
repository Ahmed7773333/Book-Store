// marked_db.g.dart

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marked_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MarkedDbTypeAdapter extends TypeAdapter<MarkedDb> {
  @override
  final int typeId = HiveTypes.markedDb;

  @override
  MarkedDb read(BinaryReader reader) {
    return MarkedDb(
      title: reader.read() as String?,
      author: reader.read() as String?,
      currencyCode: reader.read() as String?,
      amount: reader.read() as num?,
      averageRating: reader.read() as num?,
      thumbnail: reader.read() as Uint8List?,
      description: reader.read() as String?,
      isBooked: reader.read() as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MarkedDb obj) {
    writer
      ..write(obj.title)
      ..write(obj.author)
      ..write(obj.currencyCode)
      ..write(obj.amount)
      ..write(obj.averageRating)
      ..write(obj.thumbnail)
      ..write(obj.description)
      ..write(obj.isBooked);
  }
}

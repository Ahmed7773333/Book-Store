import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:booh_store_app/core/cache/hive_helper/hive_types.dart';
import 'package:booh_store_app/core/cache/hive_helper/hive_adapters.dart';
import 'package:booh_store_app/core/cache/hive_helper/marked_db_fields.dart';

part 'marked_db.g.dart';

@HiveType(typeId: HiveTypes.markedDb, adapterName: HiveAdapters.markedDb)
class MarkedDb extends HiveObject {
  @HiveField(MarkedDbFields.title)
  String? title;
  @HiveField(MarkedDbFields.author)
  String? author;
  @HiveField(MarkedDbFields.currencyCode)
  String? currencyCode;
  @HiveField(MarkedDbFields.amount)
  num? amount;
  @HiveField(MarkedDbFields.averageRating)
  num? averageRating;
  @HiveField(MarkedDbFields.thumbnail)
  Uint8List? thumbnail;
  @HiveField(MarkedDbFields.description)
  String? description;
  @HiveField(MarkedDbFields.isBooked)
  bool isBooked;
  MarkedDb({
    this.title,
    this.author,
    this.currencyCode,
    this.amount,
    this.averageRating,
    this.thumbnail,
    this.description,
    required this.isBooked,
  });
}

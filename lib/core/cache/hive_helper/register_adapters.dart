import 'package:hive/hive.dart';
import 'package:booh_store_app/core/cache/marked_db.dart';

void registerAdapters() {
  Hive.registerAdapter(MarkedDbTypeAdapter());
}

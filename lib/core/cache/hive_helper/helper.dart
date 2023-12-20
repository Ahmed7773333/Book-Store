import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as pathh;

import 'package:booh_store_app/core/cache/marked_db.dart';

class MarkedDbHelper {
  static const String boxName = 'MarkedDbHelper';

  static add(MarkedDb category) {
    Box<MarkedDb> categoryBox = Hive.box(boxName);
    categoryBox.add(category);
  }

  static update(dynamic id, MarkedDb category) {
    Box<MarkedDb> categoryBox = Hive.box(boxName);
    categoryBox.put(id, category);
  }

  static List<MarkedDb> getAll() {
    Box<MarkedDb> categoryBox = Hive.box(boxName);
    return categoryBox.values.toList().cast<MarkedDb>();
  }

  static MarkedDb? getById(int id) {
    Box<MarkedDb> categoryBox = Hive.box(boxName);
    return categoryBox.getAt(id);
  }

  static delete(MarkedDb element) {
    Box<MarkedDb> categoryBox = Hive.box(boxName);
    categoryBox.delete(element.key);
  }

  static cler() {
    Box<MarkedDb> categoryBox = Hive.box(boxName);
    categoryBox.clear();
  }
}

registsHive() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathh.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(MarkedDbTypeAdapter());
  await Hive.openBox<MarkedDb>(MarkedDbHelper.boxName);
}

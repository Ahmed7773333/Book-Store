import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'core/cache/hive_helper/helper.dart';
import 'core/utils/my_bloc_observer.dart';
import 'my_app.dart';

void main() async {
  await registsHive();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

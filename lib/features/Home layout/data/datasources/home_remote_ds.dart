import 'package:booh_store_app/features/Home%20layout/data/models/book_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/eror/failuers.dart';

abstract class HomeRemoteDS {
  Future<Either<Failures, BookModel>> getBooks(String q);
}

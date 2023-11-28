import 'package:booh_store_app/core/eror/failuers.dart';
import 'package:booh_store_app/features/Home%20layout/data/models/book_model.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/home_repo.dart';
import '../datasources/home_remote_ds_impl.dart';

class HomeRepoImpl implements HomeRepo {
  HomeRemoteDSImpl homeRemoteDSImpl;

  HomeRepoImpl(this.homeRemoteDSImpl);

  @override
  Future<Either<Failures, BookModel>> getBooks(String q) {
    return homeRemoteDSImpl.getBooks(q);
  }
}

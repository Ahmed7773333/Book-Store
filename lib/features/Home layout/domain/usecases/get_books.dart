import 'package:booh_store_app/features/Home%20layout/data/models/book_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/eror/failuers.dart';
import '../repositories/home_repo.dart';

class GetBooksUsecase {
  GetBooksUsecase(this.repo);
  HomeRepo repo;

  Future<Either<Failures, BookModel>> call(String q) => repo.getBooks(q);
}

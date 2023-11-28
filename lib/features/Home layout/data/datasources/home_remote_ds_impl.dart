import 'package:booh_store_app/features/Home%20layout/data/models/book_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../core/api/api_manager.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/eror/failuers.dart';
import 'home_remote_ds.dart';

class HomeRemoteDSImpl implements HomeRemoteDS {
  ApiManager apiManager;

  HomeRemoteDSImpl(this.apiManager);

  @override
  Future<Either<Failures, BookModel>> getBooks(String q) async {
    try {
      Response response = await apiManager.getData('${EndPoints.books}$q');
      BookModel model = BookModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      debugPrint(e.toString());
      return Left(RemoteFailure(message: e.toString()));
    }
  }
}

import 'package:booh_store_app/core/cache/hive_helper/helper.dart';
import 'package:booh_store_app/core/cache/marked_db.dart';
import 'package:booh_store_app/features/Home%20layout/data/models/book_model.dart';
import 'package:booh_store_app/features/Home%20layout/domain/usecases/get_books.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/eror/failuers.dart';

part 'home_layout_event.dart';
part 'home_layout_state.dart';

class HomeLayoutBloc extends Bloc<HomeLayoutEvent, HomeLayoutState> {
  static HomeLayoutBloc get(context) => BlocProvider.of(context);
  GetBooksUsecase getBooksUsecase;
  List<MarkedDb> resultBooked = [];
  List<MarkedDb> resultCart = [];

  HomeLayoutBloc(this.getBooksUsecase) : super(HomeLayoutInitial()) {
    on<HomeLayoutEvent>((event, emit) async {
      if (event is GetBestSellBooks) {
        emit(state.copWith(status: ScreenStatus.homeLoading));
        var result = await getBooksUsecase('Harry Potter&maxResults=40');
        result.fold((l) {
          emit(state.copWith(
              status: ScreenStatus.bestSellBooksError, failures: l));
        }, (r) {
          emit(state.copWith(
              status: ScreenStatus.bestSellBookssSuccess,
              bestSellBooks: r.items));
        });
      } else if (event is SearchForBook) {
        emit(state.copWith(status: ScreenStatus.searchLoading));
        var result = await getBooksUsecase(event.query);
        result.fold((l) {
          emit(state.copWith(
              status: ScreenStatus.searchedBooksError, failures: l));
        }, (r) {
          emit(state.copWith(
              status: ScreenStatus.searchedBookssSuccess,
              searchedBooks: r.items));
        });
      } else if (event is GetNewestBooks) {
        emit(state.copWith(status: ScreenStatus.homeLoading));
        var result = await getBooksUsecase('2021&maxResults=40');
        result.fold((l) {
          emit(state.copWith(
              status: ScreenStatus.newestBooksError, failures: l));
        }, (r) {
          emit(state.copWith(
              status: ScreenStatus.newestBookssSuccess, newestBooks: r.items));
        });
      } else if (event is GetBookedBooks) {
        emit(state.copWith(status: ScreenStatus.homeLoading));
        resultBooked = MarkedDbHelper.getAll()
            .where((element) => element.isBooked)
            .toList();
        emit(state.copWith(status: ScreenStatus.getMarked));
      } else if (event is GetCartBooks) {
        emit(state.copWith(status: ScreenStatus.homeLoading));
        resultBooked = MarkedDbHelper.getAll()
            .where((element) => !element.isBooked)
            .toList();
        emit(state.copWith(status: ScreenStatus.getcarted));
      }
    });
  }
}

// ignore_for_file: must_be_immutable
part of 'home_layout_bloc.dart';

enum ScreenStatus {
  init,
  homeLoading,
  searchLoading,
  bestSellBookssSuccess,
  bestSellBooksError,
  newestBookssSuccess,
  newestBooksError,
  searchedBookssSuccess,
  searchedBooksError,
  getMarked,
  getcarted,
}

@immutable
class HomeLayoutState {
  ScreenStatus? status;
  List<Items>? bestSellBooks;
  List<Items>? newestBooks;

  List<Items>? searchedBooks;

  Failures? failures;

  HomeLayoutState({
    this.status,
    this.bestSellBooks,
    this.searchedBooks,
    this.newestBooks,
    this.failures,
  });

  HomeLayoutState copWith(
      {ScreenStatus? status,
      List<Items>? bestSellBooks,
      List<Items>? newestBooks,
      List<Items>? searchedBooks,
      Failures? failures}) {
    return HomeLayoutState(
      failures: failures ?? this.failures,
      status: status ?? this.status,
      bestSellBooks: bestSellBooks ?? this.bestSellBooks,
      newestBooks: newestBooks ?? this.newestBooks,
      searchedBooks: searchedBooks ?? this.searchedBooks,
    );
  }
}

class HomeLayoutInitial extends HomeLayoutState {
  HomeLayoutInitial() : super(status: ScreenStatus.init);
}

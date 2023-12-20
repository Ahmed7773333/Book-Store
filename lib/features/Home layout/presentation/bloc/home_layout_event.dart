part of 'home_layout_bloc.dart';

abstract class HomeLayoutEvent extends Equatable {
  const HomeLayoutEvent();

  @override
  List<Object> get props => [];
}

class GetBestSellBooks extends HomeLayoutEvent {}

class GetNewestBooks extends HomeLayoutEvent {}

class GetBookedBooks extends HomeLayoutEvent {}

class GetCartBooks extends HomeLayoutEvent {}

class SearchForBook extends HomeLayoutEvent {
  final String query;

  const SearchForBook({required this.query});
}

import 'package:equatable/equatable.dart';

abstract class ClaimsEvent extends Equatable {
  const ClaimsEvent();

  @override
  List<Object> get props => [];
}

class FetchDataClaims extends ClaimsEvent {}

// Event for searching claims.
class SearchClaims extends ClaimsEvent {
  final String query;
  const SearchClaims({required this.query});

  @override
  List<Object> get props => [query];
}

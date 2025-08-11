import 'package:equatable/equatable.dart';

abstract class ClaimsEvent extends Equatable {
  const ClaimsEvent();

  @override
  List<Object> get props => [];
}

class FetchClaims extends ClaimsEvent {}

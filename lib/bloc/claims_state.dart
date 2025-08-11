import 'package:equatable/equatable.dart';
import 'package:flutter_application_test/models/claims_model.dart';

abstract class ClaimsState extends Equatable {
  const ClaimsState();

  @override
  List<Object> get props => [];
}

// Initial state of the BLoC before any events are processed.
class ClaimsInitial extends ClaimsState {}

// State indicating that claims data is being loaded.
class ClaimsLoading extends ClaimsState {}

// State containing the list of claims after a successful fetch.
class ClaimsLoaded extends ClaimsState {
  final List<Claim> allClaims;
  final List<Claim> filteredClaims;

  const ClaimsLoaded({required this.allClaims, required this.filteredClaims});

  @override
  List<Object> get props => [allClaims, filteredClaims];
}

// State indicating that an error occurred during data fetching.
class ClaimsError extends ClaimsState {
  final String message;
  const ClaimsError({required this.message});

  @override
  List<Object> get props => [message];
}

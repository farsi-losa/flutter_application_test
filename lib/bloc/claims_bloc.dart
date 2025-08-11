import 'package:flutter_application_test/bloc/claims_event.dart';
import 'package:flutter_application_test/bloc/claims_state.dart';
import 'package:flutter_application_test/models/claims_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ClaimsBloc extends Bloc<ClaimsEvent, ClaimsState> {
  ClaimsBloc() : super(ClaimsInitial()) {
    on<FetchClaims>(_onFetchClaims);
    on<SearchClaims>(_onSearchClaims);
  }

  Future<void> _onFetchClaims(
    FetchClaims event,
    Emitter<ClaimsState> emit,
  ) async {
    emit(ClaimsLoading());

    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final List<Claim> claims =
            jsonData.map((json) => Claim.fromJson(json)).toList();

        // Emit the loaded state with the full list of claims.
        // Initially, the filtered list is the same as the full list.
        emit(ClaimsLoaded(allClaims: claims, filteredClaims: claims));
      } else {
        emit(
          const ClaimsError(message: 'Failed to load claims. Status code: 404'),
        );
      }
    } catch (e) {
      emit(ClaimsError(message: 'An error occurred: $e'));
    }
  }

  // Event handler for searching claims.
  void _onSearchClaims(SearchClaims event, Emitter<ClaimsState> emit) {
    final currentState = state;
    if (currentState is ClaimsLoaded) {
      final query = event.query.toLowerCase();
      final filteredClaims =
          currentState.allClaims.where((claim) {
            return claim.title.toLowerCase().contains(query) ||
                claim.body.toLowerCase().contains(query);
          }).toList();

      // Emit a state with the filtered list.
      emit(
        ClaimsLoaded(
          allClaims: currentState.allClaims,
          filteredClaims: filteredClaims,
        ),
      );
    }
  }
}

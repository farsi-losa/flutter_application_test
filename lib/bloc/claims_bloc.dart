import 'package:flutter_application_test/bloc/claims_event.dart';
import 'package:flutter_application_test/bloc/claims_state.dart';
import 'package:flutter_application_test/models/claims_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ClaimsBloc extends Bloc<ClaimsEvent, ClaimsState> {
  ClaimsBloc() : super(ClaimsInitial()) {
    on<FetchClaims>(_onFetchClaims);
  }

  Future<void> _onFetchClaims(
    FetchClaims event,
    Emitter<ClaimsState> emit,
  ) async {
    // Emit loading state before starting the API call.
    emit(ClaimsLoading());

    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );

      if (response.statusCode == 200) {
        // Parse the JSON data into a list of Claims.
        final List<dynamic> jsonData = json.decode(response.body);
        final List<Claim> claims =
            jsonData.map((json) => Claim.fromJson(json)).toList();

        // Emit the loaded state with the fetched claims.
        emit(ClaimsLoaded(claims: claims));
      } else {
        // If the server returns an error code, emit an error state.
        emit(
          const ClaimsError(message: 'Failed to load claims. Status code: 404'),
        );
      }
    } catch (e) {
      // Catch any exceptions during the API call and emit an error state.
      emit(ClaimsError(message: 'An error occurred: $e'));
    }
  }
}

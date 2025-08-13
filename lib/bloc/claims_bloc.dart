import 'dart:math' as developer;

import 'package:flutter_application_test/bloc/claims_event.dart';
import 'package:flutter_application_test/bloc/claims_state.dart';
import 'package:flutter_application_test/models/claims_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ClaimsBloc extends Bloc<ClaimsEvent, ClaimsState> {
  ClaimsBloc() : super(ClaimsInitial()) {
    on<FetchDataClaims>(_onFetchDataClaim);
    on<SearchClaims>(_onSearchClaims);
  }

  Future<void> _onFetchDataClaim(
    FetchDataClaims event,
    Emitter<ClaimsState> emit,
  ) async {
    emit(ClaimsLoading());

    // Fetch claims and users data from the APIs.
    try {
      final responseClaims = await Future.wait([
        _onFetchClaims(),
        _onFetchUsers(),
      ]);
      Map<String, Map<String, dynamic>> map1 = {
        for (var item in responseClaims[0]) item['id'].toString(): item,
      };

      // new list for the combined results
      List<Claim> claimsData = [];

      // Iterate through the second list and combine objects
      for (var item2 in responseClaims[1]) {
        String id = item2['id'].toString();
        if (map1.containsKey(id)) {
          // If a match is found, merge the two maps
          Map<String, dynamic> merged = {...map1[id]!, ...item2};
          map1[id] = merged; // Update the map with the merged object
        } else {
          // If no match, add the object from the second list as a new item
          map1[id] = item2;
        }
      }

      // Convert the map back to a list of Claim objects
      claimsData =
          map1.values
              .map(
                (json) => Claim.fromJson({
                  ...json,
                  'name': json['name'] ?? 'Unknown', // Ensure name is included
                }),
              )
              .toList();

      emit(ClaimsLoaded(allClaims: claimsData, filteredClaims: claimsData));
    } catch (e) {
      emit(ClaimsError(message: 'An error occurred: $e'));
    }
  }

  Future<List<dynamic>> _onFetchClaims() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data from API 1');
    }
  }

  Future<List<dynamic>> _onFetchUsers() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data from API 1');
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

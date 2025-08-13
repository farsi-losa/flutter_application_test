import 'package:flutter_application_test/bloc/claims_bloc.dart';
import 'package:flutter_application_test/bloc/claims_event.dart';
import 'package:flutter_application_test/bloc/claims_state.dart';
import 'package:flutter_application_test/models/claims_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  // ===== BLoC UNIT TESTS =====
  group('ClaimsBloc', () {
    final mockClaimsList = [
      const Claim(
        userId: 1,
        id: 1,
        name: 'John Doe',
        title: 'Car Accident',
        body: 'Minor fender-bender.',
      ),
      const Claim(
        userId: 2,
        id: 2,
        name: 'Jane Smith',
        title: 'Property Damage',
        body: 'Water leak in the kitchen.',
      ),
    ];

    // Test the initial state
    blocTest<ClaimsBloc, ClaimsState>(
      'emits [ClaimsLoading] when created',
      build: () => ClaimsBloc(),
      expect: () => [],
    );

    // Test searching for claims
    blocTest<ClaimsBloc, ClaimsState>(
      'emits [ClaimsLoaded] with filtered claims when SearchClaims is added',
      build: () {
        return ClaimsBloc();
      },
      seed:
          () => ClaimsLoaded(
            allClaims: mockClaimsList,
            filteredClaims: mockClaimsList,
          ),
      act: (bloc) => bloc.add(const SearchClaims(query: 'Car')),
      expect:
          () => [
            ClaimsLoaded(
              allClaims: mockClaimsList,
              filteredClaims: [mockClaimsList[0]],
            ),
          ],
    );

    // Test searching with an empty query
    blocTest<ClaimsBloc, ClaimsState>(
      'emits [ClaimsLoaded] with all claims when an empty SearchClaims is added',
      build: () {
        return ClaimsBloc();
      },
      seed: () => ClaimsLoaded(allClaims: mockClaimsList, filteredClaims: []),
      act: (bloc) => bloc.add(const SearchClaims(query: '')),
      expect:
          () => [
            ClaimsLoaded(
              allClaims: mockClaimsList,
              filteredClaims: mockClaimsList,
            ),
          ],
    );
  });
}

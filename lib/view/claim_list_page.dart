import 'package:flutter/material.dart';
import 'package:flutter_application_test/bloc/claims_bloc.dart';
import 'package:flutter_application_test/bloc/claims_event.dart';
import 'package:flutter_application_test/bloc/claims_state.dart';
import 'package:flutter_application_test/view/claim_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClaimsScreen extends StatelessWidget {
  const ClaimsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Insurance Claims')),
      body: Center(
        // BlocBuilder listens to the ClaimsBloc state and rebuilds the UI accordingly.
        child: BlocBuilder<ClaimsBloc, ClaimsState>(
          builder: (context, state) {
            // Display an initial message and button.
            if (state is ClaimsInitial) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Tap the button to fetch claims.',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Dispatch the FetchClaims event to the BLoC.
                      context.read<ClaimsBloc>().add(FetchClaims());
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Fetch Claims'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              );
            }
            // Display a loading indicator.
            if (state is ClaimsLoading) {
              return const CircularProgressIndicator();
            }
            // Display the list of claims.
            if (state is ClaimsLoaded) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: state.claims.length,
                  itemBuilder: (context, index) {
                    final claim = state.claims[index];
                    return ClaimCard(claim: claim);
                  },
                ),
              );
            }
            // Display an error message.
            if (state is ClaimsError) {
              return Text(state.message);
            }
            // Fallback for any unexpected state.
            return const Text('Something went wrong!');
          },
        ),
      ),
    );
  }
}

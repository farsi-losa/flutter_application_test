import 'package:flutter/material.dart';
import 'package:flutter_application_test/bloc/claims_bloc.dart';
import 'package:flutter_application_test/bloc/claims_event.dart';
import 'package:flutter_application_test/bloc/claims_state.dart';
import 'package:flutter_application_test/view/claim_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClaimsScreen extends StatefulWidget {
  const ClaimsScreen({super.key});

  @override
  State<ClaimsScreen> createState() => _ClaimsScreenState();
}

class _ClaimsScreenState extends State<ClaimsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Start listening to the text field changes to dispatch search events.
    _searchController.addListener(() {
      context.read<ClaimsBloc>().add(
        SearchClaims(query: _searchController.text),
      );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insurance Claims'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by title or body...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search),
                suffixIcon:
                    _searchController.text.isNotEmpty
                        ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                        : null,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: BlocBuilder<ClaimsBloc, ClaimsState>(
          builder: (context, state) {
            // The loading indicator is shown immediately after the app starts.
            if (state is ClaimsLoading) {
              return const CircularProgressIndicator();
            }
            if (state is ClaimsLoaded) {
              // Check if the filtered list is empty to show a message.
              if (state.filteredClaims.isEmpty) {
                return const Text('No claims found.');
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  // Use the filteredClaims list for the UI.
                  itemCount: state.filteredClaims.length,
                  itemBuilder: (context, index) {
                    final claim = state.filteredClaims[index];
                    return ClaimCard(claim: claim);
                  },
                ),
              );
            }
            if (state is ClaimsError) {
              return Text(state.message);
            }
            return const Text('Something went wrong!');
          },
        ),
      ),
    );
  }
}

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
    return BlocConsumer<ClaimsBloc, ClaimsState>(
      listener: (context, state) {
        // Only listen for the ClaimsError state.
        if (state is ClaimsError) {
          // Show a SnackBar with the error message.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
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
          body: Center(child: _buildBody(state)),
        );
      },
    );
  }

  Widget _buildBody(ClaimsState state) {
    if (state is ClaimsLoading) {
      return const CircularProgressIndicator();
    }
    if (state is ClaimsLoaded) {
      if (state.filteredClaims.isEmpty) {
        return const Text('No claims found.');
      }
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: state.filteredClaims.length,
          itemBuilder: (context, index) {
            final claim = state.filteredClaims[index];
            return ClaimCard(claim: claim);
          },
        ),
      );
    }
    // If the state is ClaimsError, the listener will handle it, and we can just show an empty container.
    return const SizedBox.shrink();
  }
}

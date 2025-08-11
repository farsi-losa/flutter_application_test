import 'package:flutter/material.dart';
import 'package:flutter_application_test/bloc/claims_bloc.dart';
import 'package:flutter_application_test/bloc/claims_event.dart';
import 'package:flutter_application_test/view/claim_list_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const ClaimsApp());
}

class ClaimsApp extends StatelessWidget {
  const ClaimsApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide the ClaimsBloc to the entire application.
    return BlocProvider(
      create: (context) => ClaimsBloc()..add(FetchClaims()),
      child: MaterialApp(
        title: 'Insurance Claims',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          cardTheme: CardTheme(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        home: const ClaimsScreen(),
      ),
    );
  }
}

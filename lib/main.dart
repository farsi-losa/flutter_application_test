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
      create: (context) => ClaimsBloc()..add(FetchDataClaims()),
      child: MaterialApp(
        title: 'Insurance Claims',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(
            color: Colors.cyan, // Sets a custom color for the AppBar
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const ClaimsScreen(),
      ),
    );
  }
}

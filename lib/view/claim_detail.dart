import 'package:flutter/material.dart';
import 'package:flutter_application_test/models/claims_model.dart';

// widget for the detail page.
class ClaimDetailPage extends StatelessWidget {
  final Claim claim;
  const ClaimDetailPage({super.key, required this.claim});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Claim Details')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                claim.title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Claim ID: ${claim.id}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Claimant ID: ${claim.userId}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Divider(height: 32),
              Text(
                'Description:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(claim.body, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}

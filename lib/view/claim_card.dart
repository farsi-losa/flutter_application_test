import 'package:flutter/material.dart';
import 'package:flutter_application_test/models/claims_model.dart';
import 'package:flutter_application_test/view/claim_detail.dart';

class ClaimCard extends StatelessWidget {
  final Claim claim;
  const ClaimCard({super.key, required this.claim});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to the detail page when the card is tapped.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClaimDetailPage(claim: claim),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Claim ID: ${claim.id}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                claim.title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                claim.body,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Claimant ID: ${claim.userId}',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

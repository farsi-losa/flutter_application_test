import 'package:flutter_application_test/models/claims_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // ===== MODEL UNIT TESTS =====
  group('Claim Model', () {
    test('fromJson should correctly parse a JSON map into a Claim object', () {
      final Map<String, dynamic> json = {
        "userId": 1,
        "id": 1,
        "title": "Claim 1",
        "body": "Description 1",
      };

      final claim = Claim.fromJson(json);

      expect(claim.userId, 1);
      expect(claim.id, 1);
      expect(claim.title, "Claim 1");
      expect(claim.body, "Description 1");
    });
  });
}

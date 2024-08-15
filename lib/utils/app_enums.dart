import 'package:flutter/material.dart';
import 'package:travel_claim/views/style/colors.dart';

enum ClaimStatus {
  pending,
  approved,
  rejected,
  settled,
  none,
}

enum TransactionType {
  debit,
  credit
}


extension ClaimStatusExtension on ClaimStatus {
  String get title {
    switch (this) {
      case ClaimStatus.pending:
        return 'Pending';
      case ClaimStatus.approved:
        return 'Approved';
      case ClaimStatus.rejected:
        return 'Rejected';
      case ClaimStatus.settled:
        return 'Paid';
      default:
        return '';
    }
  }
}

extension ClaimStatusColorExtension on ClaimStatus {
  Color get color {
    switch (this) {
      case ClaimStatus.pending:
        return Color(0xffFFC10A);
      case ClaimStatus.approved:
        return Colors.green;
      case ClaimStatus.rejected:
        return pinkreject;
      case ClaimStatus.settled:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

extension ClaimStatusToEnumExtension on String {
  ClaimStatus get toClaimStatus {
    switch (this) {
      case 'Pending':
        return ClaimStatus.pending;
      case 'Approved':
        return ClaimStatus.approved;
      case 'Rejected':
        return ClaimStatus.rejected;
      case 'Settled':
        return ClaimStatus.settled;
      case 'Paid':
        return ClaimStatus.settled;
      default:
        return ClaimStatus.none;
    }
  }
}
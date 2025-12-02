import 'package:flutter/material.dart';
import 'package:travel_claim/views/style/colors.dart';

enum ClaimStatus {
  pending,
  approved,
  rejected,
  settled,
  resubmitted,
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
      case ClaimStatus.resubmitted:
        return 'ReSubmited';
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
      case ClaimStatus.resubmitted:
        return pinkreject;
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



enum Permission {
  newClaim,
  requestAdvance,
  drafts,
  history,
  claimApprovals,
  advanceApprovals,
  specialApprovals,
  cmdApprovals,
}
extension PermissionCheck on int {
  List<Permission> get permissions {
    switch (this) {
      case 5:
        return [
          Permission.newClaim,
          Permission.requestAdvance,
          Permission.drafts,
          Permission.history,
           Permission.claimApprovals,
        ];
      case 4:
        return [
          Permission.newClaim,
          Permission.requestAdvance,
          Permission.drafts,
          Permission.history,
          Permission.claimApprovals,
            //next update
        ];
      case 3:
        return [
          Permission.newClaim,
          Permission.requestAdvance,
          Permission.drafts,
          Permission.history,
          Permission.claimApprovals,
         // Permission.advanceApprovals,
        ];
      case 2:
        return [
          Permission.newClaim,
          Permission.requestAdvance,
          Permission.drafts,
          Permission.history,
          Permission.claimApprovals,
         // Permission.advanceApprovals,
        ];
      case 1:
        return [
          Permission.newClaim,
          Permission.requestAdvance,
          Permission.drafts,
          Permission.history,
          Permission.claimApprovals,
         // Permission.advanceApprovals,
          Permission.specialApprovals,
        ];
      case 0:
        return [
          Permission.claimApprovals,
          Permission.advanceApprovals,
          Permission.specialApprovals,
         // Permission.cmdApprovals,
        ];
      default:
        return [];
    }
  }

  bool hasPermission(Permission permission) {
    return permissions.contains(permission);
  }
}

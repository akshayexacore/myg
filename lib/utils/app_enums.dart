enum PointTypes {
  parking,
  billScanning,
  voucherRedeem,
  none,
}

enum TransactionType {
  debit,
  credit
}


extension PointTypesExtension on PointTypes {
  String get title {
    switch (this) {
      case PointTypes.parking:
        return 'Parking';
      case PointTypes.billScanning:
        return 'Bill Scanning';
      case PointTypes.voucherRedeem:
        return 'Voucher Redeem';
      default:
        return '';
    }
  }
}

extension PointTypesToEnumExtension on String {
  PointTypes get toPointType {
    switch (this) {
      case 'PARKING':
        return PointTypes.parking;
      case 'BILL_SCANNING':
        return PointTypes.billScanning;
      case 'VOUCHER_REDEEM':
        return PointTypes.voucherRedeem;
      default:
        return PointTypes.none;
    }
  }
}
extension CustomExtension on String {
  String toInitial() {
    // separate each word
    var parts = this.split(' ');
    var letterLimit = 2;
    var initial = '';

    if (parts.isEmpty || parts.first.isEmpty) {
      return '';
    }
    // check length
    if (parts.length > 1) {
      for (var i = 0; i < letterLimit; i++) {
        // combine the first letters of each word
        initial += parts[i][0];
      }
    } else {
      // this default, if word <=1
      initial = parts[0][0];
    }
    return initial;
  }
}

extension FloorNameExtension on int {
  String toReadableFloorName() {
    if (this == 0) {
      return 'Ground Floor';
    } else if (this == 1) {
      return 'First Floor';
    } else {
      // Determine the correct suffix for the floor number
      String suffix;
      if (this % 100 >= 11 && this % 100 <= 13) {
        suffix = 'th';
      } else {
        switch (this % 10) {
          case 1:
            suffix = 'st';
            break;
          case 2:
            suffix = 'nd';
            break;
          case 3:
            suffix = 'rd';
            break;
          default:
            suffix = 'th';
        }
      }
      return '$this$suffix Floor';
    }
  }
}

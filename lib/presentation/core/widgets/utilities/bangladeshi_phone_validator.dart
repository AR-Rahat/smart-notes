class BangladeshiPhoneValidator {
  /// Validates Bangladeshi phone numbers
  /// Supports formats: +8801xxxxxxxxx, 8801xxxxxxxxx, 01xxxxxxxxx
  /// Valid operators: Grameenphone, Banglalink, Robi, Airtel, Teletalk
  static bool isValidBangladeshiPhone(String phone) {
    if (phone.isEmpty) return false;

    // Remove all spaces and dashes
    String cleanPhone = phone.replaceAll(RegExp(r'[\s-]'), '');

    // Handle different formats
    String normalizedPhone = _normalizePhone(cleanPhone);

    // Check if normalized phone is exactly 11 digits starting with 01
    if (normalizedPhone.length != 11 || !normalizedPhone.startsWith('01')) {
      return false;
    }

    // Check if all characters are digits
    if (!RegExp(r'^\d+$').hasMatch(normalizedPhone)) {
      return false;
    }

    // Validate operator prefix
    return _isValidOperatorPrefix(normalizedPhone);
  }

  /// Normalizes phone number to 01xxxxxxxxx format
  static String _normalizePhone(String phone) {
    // Remove country code +880 or 880
    if (phone.startsWith('+880')) {
      phone = phone.substring(4);
    } else if (phone.startsWith('880')) {
      phone = phone.substring(3);
    }

    // Ensure it starts with 01
    if (phone.startsWith('1') && phone.length == 10) {
      phone = '0' + phone;
    }

    return phone;
  }

  /// Validates operator prefix based on current BD mobile operators
  static bool _isValidOperatorPrefix(String phone) {
    String prefix = phone.substring(0, 3);

    // Valid prefixes for major operators in Bangladesh
    List<String> validPrefixes = [
      '017', // Grameenphone
      '013', // Grameenphone
      '019', // Banglalink
      '014', // Banglalink
      '018', // Robi
      '016', // Airtel
      '015', // Teletalk
      '011', // Citycell (legacy)
    ];

    return validPrefixes.contains(prefix);
  }

  /// Returns the operator name for a valid phone number
  static String? getOperatorName(String phone) {
    if (!isValidBangladeshiPhone(phone)) return null;

    String normalizedPhone = _normalizePhone(phone.replaceAll(RegExp(r'[\s-]'), ''));
    String prefix = normalizedPhone.substring(0, 3);

    switch (prefix) {
      case '017':
      case '013':
        return 'Grameenphone';
      case '019':
      case '014':
        return 'Banglalink';
      case '018':
        return 'Robi';
      case '016':
        return 'Airtel';
      case '015':
        return 'Teletalk';
      case '011':
        return 'Citycell';
      default:
        return null;
    }
  }

  /// Formats phone number to standard format
  static String formatPhone(String phone) {
    if (!isValidBangladeshiPhone(phone)) {
      throw ArgumentError('Invalid Bangladeshi phone number');
    }

    String normalizedPhone = _normalizePhone(phone.replaceAll(RegExp(r'[\s-]'), ''));
    return '+880${normalizedPhone.substring(1)}';
  }
}

// // Example usage and testing
// void main() {
//   // Test cases
//   List<String> testNumbers = [
//     '+8801712345678',
//     '8801712345678',
//     '01712345678',
//     '1712345678',
//     '017-1234-5678',
//     '017 1234 5678',
//     '01912345678',
//     '01812345678',
//     '01612345678',
//     '01512345678',
//     '01234567890', // Invalid prefix
//     '017123456789', // Too long
//     '0171234567', // Too short
//     'invalid',
//     '',
//   ];
//
//   print('Bangladeshi Phone Number Validation Results:');
//   print('=' * 50);
//
//   for (String number in testNumbers) {
//     bool isValid = BangladeshiPhoneValidator.isValidBangladeshiPhone(number);
//     String? operator = BangladeshiPhoneValidator.getOperatorName(number);
//
//     print('Number: $number');
//     print('Valid: $isValid');
//     if (isValid) {
//       print('Operator: $operator');
//       try {
//         String formatted = BangladeshiPhoneValidator.formatPhone(number);
//         print('Formatted: $formatted');
//       } catch (e) {
//         print('Format error: $e');
//       }
//     }
//     print('-' * 30);
//   }
// }

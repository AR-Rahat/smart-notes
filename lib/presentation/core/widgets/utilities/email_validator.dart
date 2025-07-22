class EmailValidator {
  /// Validates email addresses according to RFC 5322 standards
  /// with additional common-sense restrictions
  static bool isValidEmail(String email) {
    if (email.isEmpty) return false;

    // Basic format check
    if (!_hasBasicEmailFormat(email)) return false;

    // Split email into local and domain parts
    List<String> parts = email.split('@');
    if (parts.length != 2) return false;

    String localPart = parts[0];
    String domainPart = parts[1];

    // Validate local part (before @)
    if (!_isValidLocalPart(localPart)) return false;

    // Validate domain part (after @)
    if (!_isValidDomainPart(domainPart)) return false;

    return true;
  }

  /// Checks basic email format using regex
  static bool _hasBasicEmailFormat(String email) {
    // Basic email pattern - not too strict but covers most cases
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      caseSensitive: false,
    );
    return emailRegex.hasMatch(email);
  }

  /// Validates the local part (before @) of email
  static bool _isValidLocalPart(String localPart) {
    // Check length (1-64 characters)
    if (localPart.isEmpty || localPart.length > 64) return false;

    // Cannot start or end with dot
    if (localPart.startsWith('.') || localPart.endsWith('.')) return false;

    // Cannot have consecutive dots
    if (localPart.contains('..')) return false;

    // Check for valid characters
    final validLocalPattern = RegExp(r'^[a-zA-Z0-9._%+-]+$');
    if (!validLocalPattern.hasMatch(localPart)) return false;

    return true;
  }

  /// Validates the domain part (after @) of email
  static bool _isValidDomainPart(String domainPart) {
    // Check length (1-255 characters)
    if (domainPart.isEmpty || domainPart.length > 255) return false;

    // Cannot start or end with dot or hyphen
    if (domainPart.startsWith('.') || domainPart.endsWith('.') ||
        domainPart.startsWith('-') || domainPart.endsWith('-')) return false;

    // Split domain into labels
    List<String> labels = domainPart.split('.');
    if (labels.length < 2) return false;

    // Validate each label
    for (String label in labels) {
      if (!_isValidDomainLabel(label)) return false;
    }

    // Check TLD (last label)
    String tld = labels.last;
    if (!_isValidTLD(tld)) return false;

    return true;
  }

  /// Validates individual domain label
  static bool _isValidDomainLabel(String label) {
    // Check length (1-63 characters)
    if (label.isEmpty || label.length > 63) return false;

    // Cannot start or end with hyphen
    if (label.startsWith('-') || label.endsWith('-')) return false;

    // Check for valid characters (alphanumeric and hyphen)
    final validLabelPattern = RegExp(r'^[a-zA-Z0-9-]+$');
    return validLabelPattern.hasMatch(label);
  }

  /// Validates Top Level Domain (TLD)
  static bool _isValidTLD(String tld) {
    // TLD must be at least 2 characters and only letters
    if (tld.length < 2 || tld.length > 63) return false;

    final tldPattern = RegExp(r'^[a-zA-Z]+$');
    return tldPattern.hasMatch(tld);
  }

  /// Checks if email is from a disposable email provider
  static bool isDisposableEmail(String email) {
    if (!isValidEmail(email)) return false;

    String domain = email.split('@')[1].toLowerCase();

    // Common disposable email domains
    Set<String> disposableDomains = {
      '10minutemail.com',
      'temp-mail.org',
      'guerrillamail.com',
      'mailinator.com',
      'yopmail.com',
      'tempmail.net',
      'throwaway.email',
      'maildrop.cc',
      'sharklasers.com',
      'fakeinbox.com',
      'dispostable.com',
      'tempail.com',
      'mohmal.com',
      'emailondeck.com',
      'spamgourmet.com',
    };

    return disposableDomains.contains(domain);
  }

  /// Extracts domain from email
  static String? getDomain(String email) {
    if (!isValidEmail(email)) return null;
    return email.split('@')[1].toLowerCase();
  }

  /// Extracts local part from email
  static String? getLocalPart(String email) {
    if (!isValidEmail(email)) return null;
    return email.split('@')[0];
  }

  /// Normalizes email address (lowercase, trim)
  static String normalizeEmail(String email) {
    return email.trim().toLowerCase();
  }

  /// Validates email with additional business rules
  static EmailValidationResult validateEmailWithDetails(String email) {
    String normalizedEmail = normalizeEmail(email);

    // Basic validation
    if (!isValidEmail(normalizedEmail)) {
      return EmailValidationResult(
        isValid: false,
        email: normalizedEmail,
        errorMessage: 'Invalid email format',
      );
    }

    // Check for disposable email
    if (isDisposableEmail(normalizedEmail)) {
      return EmailValidationResult(
        isValid: false,
        email: normalizedEmail,
        errorMessage: 'Disposable email addresses are not allowed',
      );
    }

    // Additional business rules can be added here
    String? domain = getDomain(normalizedEmail);
    String? localPart = getLocalPart(normalizedEmail);

    return EmailValidationResult(
      isValid: true,
      email: normalizedEmail,
      domain: domain,
      localPart: localPart,
    );
  }

  /// Checks if email appears to be from a business domain
  static bool isBusinessEmail(String email) {
    if (!isValidEmail(email)) return false;

    String domain = getDomain(email) ?? '';

    // Common free email providers
    Set<String> freeProviders = {
      'gmail.com',
      'yahoo.com',
      'hotmail.com',
      'outlook.com',
      'aol.com',
      'icloud.com',
      'live.com',
      'msn.com',
      'ymail.com',
      'rocketmail.com',
    };

    return !freeProviders.contains(domain);
  }
}

/// Result class for detailed email validation
class EmailValidationResult {
  final bool isValid;
  final String email;
  final String? domain;
  final String? localPart;
  final String? errorMessage;

  EmailValidationResult({
    required this.isValid,
    required this.email,
    this.domain,
    this.localPart,
    this.errorMessage,
  });

  @override
  String toString() {
    return 'EmailValidationResult(isValid: $isValid, email: $email, '
        'domain: $domain, localPart: $localPart, error: $errorMessage)';
  }
}

// // Example usage and testing
// void main() {
//   // Test cases
//   List<String> testEmails = [
//     'user@example.com',
//     'test.email@domain.co.uk',
//     'user+tag@example.org',
//     'user_name@example-domain.com',
//     'firstname.lastname@company.com',
//     'user@gmail.com',
//     'invalid.email',
//     'user@',
//     '@domain.com',
//     'user..double@domain.com',
//     'user@domain',
//     'user@domain.c',
//     'user@sub.domain.com',
//     'user@mailinator.com',
//     'very.long.email.address.that.exceeds.sixty.four.characters@domain.com',
//     'user@domain.toolongtobevalidtld',
//     'user@domain-.com',
//     'user@-domain.com',
//     'us er@domain.com',
//     'user@domain .com',
//     '',
//   ];
//
//   print('Email Validation Results:');
//   print('=' * 60);
//
//   for (String email in testEmails) {
//     bool isValid = EmailValidator.isValidEmail(email);
//     bool isDisposable = EmailValidator.isDisposableEmail(email);
//     bool isBusiness = EmailValidator.isBusinessEmail(email);
//     String normalized = EmailValidator.normalizeEmail(email);
//
//     print('Email: "$email"');
//     print('Valid: $isValid');
//
//     if (isValid) {
//       print('Domain: ${EmailValidator.getDomain(email)}');
//       print('Local Part: ${EmailValidator.getLocalPart(email)}');
//       print('Disposable: $isDisposable');
//       print('Business: $isBusiness');
//     }
//
//     print('Normalized: "$normalized"');
//
//     // Detailed validation
//     EmailValidationResult result = EmailValidator.validateEmailWithDetails(email);
//     print('Detailed Result: $result');
//
//     print('-' * 40);
//   }
// }

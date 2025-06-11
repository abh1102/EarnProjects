// class ValidationUtils {
//   static String? validateName(String? value) {
//     if (value == null || value.trim().isEmpty) return 'Please enter your name';
//     return null;
//   }
//
//   static String? validatePhone(String? value) {
//     if (value == null || value.trim().isEmpty) return 'Please enter your mobile number';
//     if (!RegExp(r'^[6-9]\d{9}\$').hasMatch(value)) return 'Enter a valid 10-digit Indian mobile number';
//     return null;
//   }
//
//   static String? validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Email is required';
//     }
//
//     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//     if (!emailRegex.hasMatch(value)) {
//       return 'Enter a valid email';
//     }
//
//     return null; // ✅ return null to indicate the input is valid
//   }
//
//   static String? validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your password';
//     }
//
//     final hasMinLength = value.length >= 8;
//     final hasDigit = RegExp(r'\d').hasMatch(value);
//     final hasSpecialChar = RegExp(r'[!@#\$&*~%^()\-_=+{};:,<.>?]').hasMatch(value);
//     final hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
//     final hasLowercase = RegExp(r'[a-z]').hasMatch(value);
//
//     if (!hasMinLength || !hasDigit || !hasSpecialChar || !hasUppercase || !hasLowercase) {
//       return 'Password must contain:\n'
//           '• Minimum 8 characters\n'
//           '• At least 1 uppercase & lowercase\n'
//           '• At least 1 digit\n'
//           '• At least 1 special character';
//     }
//
//     return null;
//   }
//
//
//
//   static String? validateConfirmPassword(String? value, String originalPassword) {
//     if (value == null || value.isEmpty) return 'Please confirm your password';
//     if (value != originalPassword) return 'Passwords do not match';
//     return null;
//   }
// }
class ValidationUtils {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your name';
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your mobile number';
    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) return 'Enter a valid 10-digit Indian mobile number';
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';

    final hasMinLength = value.length >= 8;
    final hasDigit = RegExp(r'\d').hasMatch(value);
    final hasSpecialChar = RegExp(r'[!@#\$&*~%^()\-_=+{};:,<.>?]').hasMatch(value);
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
    final hasLowercase = RegExp(r'[a-z]').hasMatch(value);

    if (!hasMinLength || !hasDigit || !hasSpecialChar || !hasUppercase || !hasLowercase) {
      // return 'Password must contain:\n'
      //     '• Minimum 8 characters\n'
      //     '• At least 1 uppercase & lowercase\n'
      //     '• At least 1 digit\n'
      //     '• At least 1 special character';
    }

    return null;
  }

  static String? validateConfirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != originalPassword) return 'Passwords do not match';
    return null;
  }
}
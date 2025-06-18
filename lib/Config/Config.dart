
class ApiConfig {
  static const String baseUrl = "https://earnprojects-backend.onrender.com/api";

  // Then define all endpoints like this (as final OR late static const):
  static const String signUpEndpoint = "$baseUrl/auth/complete-signup";
  static const String verifyEmailEndpoint = "$baseUrl/auth/verify-otp";
  static const String sendOtpEndpoint = "$baseUrl/auth/send-otp";
static const String plans='$baseUrl/user/get-category-wise-plans';
}
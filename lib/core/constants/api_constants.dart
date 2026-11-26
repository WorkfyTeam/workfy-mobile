class ApiConstants {
  // Base URL
  static const String baseUrl = "http://localhost:3000/api";

  static const Duration connectionTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);

  // Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String currentUserEssentialData = '/auth/me';
  static const String profile = '/profiles/me';
}
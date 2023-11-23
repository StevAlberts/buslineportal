class AuthGuard {
  static bool isAuthenticated = false;

  static Future<bool> checkAuthentication() async {
    // Implement your authentication logic here
    // For example, check if the user is logged in
    // and return true if authenticated, false otherwise
    await Future.delayed(const Duration(seconds: 2)); // Simulating authentication check
    return isAuthenticated;
  }
}
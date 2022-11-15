class ApiEndPoints {
  static final String baseurl = "http://vims.afrimedtravel.com/api/";
  static _AuthEndPoints authendpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String register = "auth/register";
  final String login = "auth/login";
  final String check_user = "auth/check-user";
  final String reset = "auth/reset-password";
}

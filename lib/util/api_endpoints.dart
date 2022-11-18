class ApiEndPoints {
  static final String baseurl = "http://vims.afrimedtravel.com/api/";
  static _AuthEndPoints authendpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String register = "auth/register";
  final String login = "auth/login";
  final String check_user = "auth/check-user";
  final String reset = "auth/reset-password";
  final String change_profile = "auth/change-profile";
  final String change_password = "auth/change-password";
  final String getProfile = "auth/get-profile";
}

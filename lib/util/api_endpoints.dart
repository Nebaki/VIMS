class ApiEndPoints {
  static final String baseurl = "https://vims.kabbatransport.com/api/";
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
  final String workOrder = "work-orders/vehicle/";
  final String workOrderHistory = "work-orders/get-history/";
  final String refreshToken = "auth/refresh";
  final String vehicle = 'vehicles/get-my-vehicles';
  final String vehiclItem = 'vehicle-intakes/get-by-vehicle/';
  final String lubrication = 'work-orders/lubrications/';
  final String workorderDetail = 'work-orders/details/';
}

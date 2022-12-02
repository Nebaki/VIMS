import 'package:get/get.dart';
import 'package:mob_app/models/vehicle/vehicle.dart';
import 'package:mob_app/repositories/vehicle_repo.dart';

class VehicleController extends GetxController {
  var vehicleList = <VehicleModel>[].obs;
  var isLoading = true.obs;
  @override
  void onInit() {
    super.onInit();
    getAllVehicles();
  }

  Future<void> getAllVehicles() async {
    var vehicle_ = await VehicleRepository.fetchVehicle();
    if (vehicle_ != null) {
      vehicleList.value = vehicle_;
      isLoading.value = false;
    }
  }
}

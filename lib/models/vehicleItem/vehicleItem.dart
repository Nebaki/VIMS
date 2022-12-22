class intakeItem {
  String? dateOfIntake;
  List<VehicleIntakeItems>? vehicleIntakeItems;
  String? createdAt;

  intakeItem({this.dateOfIntake, this.vehicleIntakeItems, this.createdAt});

  intakeItem.fromJson(Map<String, dynamic> json) {
    dateOfIntake = json['date_of_intake'];

    if (json['vehicle_intake_items'] != null) {
      vehicleIntakeItems = <VehicleIntakeItems>[];
      json['vehicle_intake_items'].forEach((v) {
        vehicleIntakeItems!.add(new VehicleIntakeItems.fromJson(v));
      });
    }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vehicleIntakeItems != null) {
      data['vehicle_intake_items'] =
          this.vehicleIntakeItems!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class VehicleIntakeItems {
  String? id;
  String? item;
  int? status;
  String? createdAt;

  VehicleIntakeItems({this.id, this.item, this.status, this.createdAt});

  VehicleIntakeItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    item = json['item'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item'] = this.item;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

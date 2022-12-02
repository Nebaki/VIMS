import '../check_user/check_user.dart';

class VehicleModel {
  String? id;
  String? plateNumber;
  String? color;
  String? model;
  String? ownerId;
  String? createdAt;
  String? updatedAt;
  Owner? owner;

  VehicleModel(
      {this.id,
      this.plateNumber,
      this.color,
      this.model,
      this.ownerId,
      this.createdAt,
      this.updatedAt,
      this.owner});

  VehicleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plateNumber = json['plate_number'];
    color = json['color'];
    model = json['model'];
    ownerId = json['owner_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> VehicleModel = new Map<String, dynamic>();
    VehicleModel['id'] = this.id;
    VehicleModel['plate_number'] = this.plateNumber;
    VehicleModel['color'] = this.color;
    VehicleModel['model'] = this.model;
    VehicleModel['owner_id'] = this.ownerId;
    VehicleModel['created_at'] = this.createdAt;
    VehicleModel['updated_at'] = this.updatedAt;
    if (this.owner != null) {
      VehicleModel['owner'] = this.owner!.toJson();
    }
    return VehicleModel;
  }
}

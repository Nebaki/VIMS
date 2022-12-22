
class Lubrications {
  String? id;
  String? oilType;
  String? measurement;
  int? quantity;
  int? unit;
  int? extended;
  String? workOrderId;
  String? createdAt;
  String? updatedAt;

  Lubrications(
      {this.id,
      this.oilType,
      this.measurement,
      this.quantity,
      this.unit,
      this.extended,
      this.workOrderId,
      this.createdAt,
      this.updatedAt});

  Lubrications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oilType = json['oil_type'];
    measurement = json['measurement'];
    quantity = json['quantity'];
    unit = json['unit'];
    extended = json['extended'];
    workOrderId = json['work_order_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['oil_type'] = this.oilType;
    data['measurement'] = this.measurement;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['extended'] = this.extended;
    data['work_order_id'] = this.workOrderId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}



class workorderDetails {
  String? id;
  String? systemCode;
  String? workAccomplishedCode;
  String? partNoDescription;
  int? quantity;
  int? unitCost;
  int? extendedCost;
  String? partFailureCode;
  String? status;
  String? workOrderId;
  String? createdAt;
  String? updatedAt;

  workorderDetails(
      {this.id,
      this.systemCode,
      this.workAccomplishedCode,
      this.partNoDescription,
      this.quantity,
      this.unitCost,
      this.extendedCost,
      this.partFailureCode,
      this.status,
      this.workOrderId,
      this.createdAt,
      this.updatedAt});

  workorderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    systemCode = json['system_code'];
    workAccomplishedCode = json['work_accomplished_code'];
    partNoDescription = json['part_no_description'];
    quantity = json['quantity'];
    unitCost = json['unit_cost'];
    extendedCost = json['extended_cost'];
    partFailureCode = json['part_failure_code'];
    status = json['status'];
    workOrderId = json['work_order_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['system_code'] = this.systemCode;
    data['work_accomplished_code'] = this.workAccomplishedCode;
    data['part_no_description'] = this.partNoDescription;
    data['quantity'] = this.quantity;
    data['unit_cost'] = this.unitCost;
    data['extended_cost'] = this.extendedCost;
    data['part_failure_code'] = this.partFailureCode;
    data['status'] = this.status;
    data['work_order_id'] = this.workOrderId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

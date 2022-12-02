class WorkOrderDetails {
  String? id;
  String? systemCode;
  String? workAccomplishedCode;
  String? partNoDescription;
  String? quantity;
  String? unitCost;
  String? extendedCost;
  String? status;
  String? createdAt;
  String? partFailureCode;

  WorkOrderDetails(
      {this.id,
      this.systemCode,
      this.workAccomplishedCode,
      this.partNoDescription,
      this.quantity,
      this.unitCost,
      this.extendedCost,
      this.status,
      this.createdAt,
      this.partFailureCode});

  WorkOrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    systemCode = json['system_code'];
    workAccomplishedCode = json['work_accomplished_code'];
    partNoDescription = json['part_no_description'];
    quantity = json['quantity'];
    unitCost = json['unit_cost'];
    extendedCost = json['extended_cost'];
    status = json['status'];
    createdAt = json['created_at'];
    partFailureCode = json['part_failure_code'];
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
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['part_failure_code'] = this.partFailureCode;
    return data;
  }
}


class WorkOrderDetails {
  String? partNoDescription;
  String? quantity;
  String? unitCost;
  String? extendedCost;
  String? status;
  String? createdAt;

  WorkOrderDetails(
      {this.partNoDescription,
      this.quantity,
      this.unitCost,
      this.extendedCost,
      this.status,
      this.createdAt});

  WorkOrderDetails.fromJson(Map<String, dynamic> json) {
    partNoDescription = json['part_no_description'];
    quantity = json['quantity'];
    unitCost = json['unit_cost'];
    extendedCost = json['extended_cost'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['part_no_description'] = this.partNoDescription;
    data['quantity'] = this.quantity;
    data['unit_cost'] = this.unitCost;
    data['extended_cost'] = this.extendedCost;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}
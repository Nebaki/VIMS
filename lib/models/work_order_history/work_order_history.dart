



class WorkOrderHistoryModel {
  String? id;
  String? totalLubricationCost;
  String? totalPartsCost;
  int? totalLabourCost;
  String? status;
  String? createdAt;
  List<WorkOrderDetails>? workOrderDetails;
  List<Lubrications>? lubrications;

  WorkOrderHistoryModel(
      {this.id,
      this.totalLubricationCost,
      this.totalPartsCost,
      this.totalLabourCost,
      this.status,
      this.createdAt,
      this.workOrderDetails,
      this.lubrications});

  WorkOrderHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalLubricationCost = json['total_lubrication_cost'];
    totalPartsCost = json['total_parts_cost'];
    totalLabourCost = json['total_labour_cost'];
    status = json['status'];
    createdAt = json['created_at'];
    if (json['work_order_details'] != null) {
      workOrderDetails = <WorkOrderDetails>[];
      json['work_order_details'].forEach((v) {
        workOrderDetails!.add(new WorkOrderDetails.fromJson(v));
      });
    }
    if (json['lubrications'] != null) {
      lubrications = <Lubrications>[];
      json['lubrications'].forEach((v) {
        lubrications!.add(new Lubrications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total_lubrication_cost'] = this.totalLubricationCost;
    data['total_parts_cost'] = this.totalPartsCost;
    data['total_labour_cost'] = this.totalLabourCost;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    if (this.workOrderDetails != null) {
      data['work_order_details'] =
          this.workOrderDetails!.map((v) => v.toJson()).toList();
    }
    if (this.lubrications != null) {
      data['lubrications'] = this.lubrications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkOrderDetails {
  String? id;
  String? systemCode;
  String? workAccomplishedCode;
  String? partNoDescription;
  int? quantity;
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

class Lubrications {
  String? id;
  String? oilType;
  int? quantity;
  String? measurement;
  String? unit;
  String? extended;
  String? createdAt;

  Lubrications(
      {this.id,
      this.oilType,
      this.quantity,
      this.measurement,
      this.unit,
      this.extended,
      this.createdAt});

  Lubrications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oilType = json['oil_type'];
    quantity = json['quantity'];
    measurement = json['measurement'];
    unit = json['unit'];
    extended = json['extended'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['oil_type'] = this.oilType;
    data['quantity'] = this.quantity;
    data['measurement'] = this.measurement;
    data['unit'] = this.unit;
    data['extended'] = this.extended;
    data['created_at'] = this.createdAt;
    return data;
  }
}

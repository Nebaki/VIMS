class my_work_order {
  String? message;
  bool? status;
  List<Data>? data;

  my_work_order({this.message, this.status, this.data});

  my_work_order.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? totalLubricationCost;
  String? totalPartsCost;
  String? totalLabourCost;
  String? status;
  String? createdAt;
  List<WorkOrderDetails>? workOrderDetails;
  List<Lubrications>? lubrications;

  Data(
      {this.totalLubricationCost,
      this.totalPartsCost,
      this.totalLabourCost,
      this.status,
      this.createdAt,
      this.workOrderDetails,
      this.lubrications});

  Data.fromJson(Map<String, dynamic> json) {
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
      {this.systemCode,
      this.workAccomplishedCode,
      this.partNoDescription,
      this.quantity,
      this.unitCost,
      this.extendedCost,
      this.status,
      this.createdAt,
      this.partFailureCode});

  WorkOrderDetails.fromJson(Map<String, dynamic> json) {
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
  String? oilType;
  String? quantity;
  String? unit;
  String? extended;
  String? createdAt;

  Lubrications(
      {this.oilType, this.quantity, this.unit, this.extended, this.createdAt});

  Lubrications.fromJson(Map<String, dynamic> json) {
    oilType = json['oil_type'];
    quantity = json['quantity'];
    unit = json['unit'];
    extended = json['extended'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oil_type'] = this.oilType;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['extended'] = this.extended;
    data['created_at'] = this.createdAt;
    return data;
  }
}

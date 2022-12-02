
import 'package:mob_app/models/work_order_for_vehicle/lubrications.dart';
import 'package:mob_app/models/work_order_for_vehicle/work_order_detail.dart';

class CurrentWorkOrderDetails {
  String? id;
  String? totalLubricationCost;
  String? totalPartsCost;
  String? totalLabourCost;
  String? status;
  String? createdAt;
  List<WorkOrderDetails>? workOrderDetails;
  List<Lubrications>? lubrications;

  CurrentWorkOrderDetails(
      {this.id,
      this.totalLubricationCost,
      this.totalPartsCost,
      this.totalLabourCost,
      this.status,
      this.createdAt,
      this.workOrderDetails,
      this.lubrications});

  CurrentWorkOrderDetails.fromJson(Map<String, dynamic> json) {
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


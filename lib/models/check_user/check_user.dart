
class CurrentWorkOrderDetails {
  CurrentWorkOrderDetails({
    required this.vehicle,
    required this.id,
    required this.totalLubricationCost,
    required this.totalPartsCost,
    required this.totalLabourCost,
    required this.status,
    required this.createdAt,
    required this.workOrderDetails,
    required this.lubrications,
  });
  late final Vehicle vehicle;
  late final String id;
  late final String totalLubricationCost;
  late final String totalPartsCost;
  late final String totalLabourCost;
  late final String status;
  late final String createdAt;
  late final List<WorkOrderDetails> workOrderDetails;
  late final List<Lubrications> lubrications;
  
  CurrentWorkOrderDetails.fromJson(Map<String, dynamic> json){
    vehicle = Vehicle.fromJson(json['vehicle']);
    id = json['id'];
    totalLubricationCost = json['total_lubrication_cost'];
    totalPartsCost = json['total_parts_cost'];
    totalLabourCost = json['total_labour_cost'];
    status = json['status'];
    createdAt = json['created_at'];
    workOrderDetails = List.from(json['work_order_details']).map((e)=>WorkOrderDetails.fromJson(e)).toList();
    lubrications = List.from(json['lubrications']).map((e)=>Lubrications.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['vehicle'] = vehicle.toJson();
    _data['id'] = id;
    _data['total_lubrication_cost'] = totalLubricationCost;
    _data['total_parts_cost'] = totalPartsCost;
    _data['total_labour_cost'] = totalLabourCost;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['work_order_details'] = workOrderDetails.map((e)=>e.toJson()).toList();
    _data['lubrications'] = lubrications.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Vehicle {
  Vehicle({
    required this.plateNumber,
    required this.color,
    required this.model,
    required this.owner,
  });
  late final String plateNumber;
  late final String color;
  late final String model;
  late final Owner owner;
  
  Vehicle.fromJson(Map<String, dynamic> json){
    plateNumber = json['plate_number'];
    color = json['color'];
    model = json['model'];
    owner = Owner.fromJson(json['owner']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['plate_number'] = plateNumber;
    _data['color'] = color;
    _data['model'] = model;
    _data['owner'] = owner.toJson();
    return _data;
  }
}

class Owner {
  Owner({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.createdAt,
  });
  late final String id;
  late final String name;
  late final String email;
  late final String phone;
  late final String createdAt;
  
  Owner.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['created_at'] = createdAt;
    return _data;
  }
}

class WorkOrderDetails {
  WorkOrderDetails({
    required this.id,
    required this.systemCode,
    required this.workAccomplishedCode,
    required this.partNoDescription,
    required this.quantity,
    required this.unitCost,
    required this.extendedCost,
    required this.status,
    required this.createdAt,
    required this.partFailureCode,
  });
  late final String id;
  late final String systemCode;
  late final String workAccomplishedCode;
  late final String partNoDescription;
  late final String quantity;
  late final String unitCost;
  late final String extendedCost;
  late final String status;
  late final String createdAt;
  late final String partFailureCode;
  
  WorkOrderDetails.fromJson(Map<String, dynamic> json){
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
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['system_code'] = systemCode;
    _data['work_accomplished_code'] = workAccomplishedCode;
    _data['part_no_description'] = partNoDescription;
    _data['quantity'] = quantity;
    _data['unit_cost'] = unitCost;
    _data['extended_cost'] = extendedCost;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['part_failure_code'] = partFailureCode;
    return _data;
  }
}

class Lubrications {
  Lubrications({
    required this.id,
    required this.oilType,
    required this.quantity,
    required this.unit,
    required this.extended,
    required this.createdAt,
  });
  late final String id;
  late final String oilType;
  late final String quantity;
  late final String unit;
  late final String extended;
  late final String createdAt;
  
  Lubrications.fromJson(Map<String, dynamic> json){
    id = json['id'];
    oilType = json['oil_type'];
    quantity = json['quantity'];
    unit = json['unit'];
    extended = json['extended'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['oil_type'] = oilType;
    _data['quantity'] = quantity;
    _data['unit'] = unit;
    _data['extended'] = extended;
    _data['created_at'] = createdAt;
    return _data;
  }
}
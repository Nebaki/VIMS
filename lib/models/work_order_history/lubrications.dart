
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

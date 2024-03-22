class Customer {
  Customer({
    this.id,
    this.name,
    this.address,
    this.balance,
    this.remarks,
    this.createDate,
    this.updateDate,
    this.bizId,
  });

  late int? id;
  late String? name;
  late String? address;
  late int? balance;
  late String? remarks;
  late String? createDate;
  late String? updateDate;
  late String? bizId;

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? '';
    address = json['address'] ?? '';
    balance = json['balance'];
    remarks = json['remarks'] ?? '';
    createDate = json['createDate'] ?? '';
    updateDate = json['updateDate'] ?? '';
    bizId = json['bizId'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['balance'] = balance;
    data['remarks'] = remarks;
    data['createDate'] = createDate;
    data['updateDate'] = updateDate;
    data['bizId'] = bizId;
    return data;
  }
}

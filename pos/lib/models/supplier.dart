class Supplier {
  Supplier({
     this.id,
     this.name,
     this.address,
     this.balance,
     this.createDate,
     this.updateDate,
     this.bizId,
  });
  late final int? id;
  late final String? name;
  late final String? address;
  late final double? balance;
  late final String? createDate;
  late final String? updateDate;
  late final String? bizId;

  Supplier.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name']  ?? '';
    address = json['address'] ?? '';
    balance = json['balance'];
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
    data['createDate'] = createDate;
    data['updateDate'] = updateDate;
    data['bizId'] = bizId;
    return data;
  }
}
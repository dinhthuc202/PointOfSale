class User {
  User({
    this.id,
    this.userName,
    this.password,
    this.groupId,
    this.name,
    this.address,
    this.email,
    this.phone,
    this.provinceId,
    this.districtId,
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
    this.status,
  });

  late int? id;
  late String? userName;
  late String? password;
  late String? groupId;
  late String? name;
  late String? address;
  late String? email;
  late String? phone;
  late int? provinceId;
  late int? districtId;
  late String? createdDate;
  late String? createdBy;
  late String? modifiedDate;
  late String? modifiedBy;
  late bool? status;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    password = null;
    groupId = json['groupId'];
    name = json['name'];
    address = json['address'];
    email = json['email'];
    phone = json['phone'];
    provinceId = json['provinceId'];
    districtId = json['districtId'];
    createdDate = json['createdDate'];
    createdBy = null;
    modifiedDate = null;
    modifiedBy = null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['password'] = password;
    data['groupId'] = groupId;
    data['name'] = name;
    data['address'] = address;
    data['email'] = email;
    data['phone'] = phone;
    data['provinceId'] = provinceId;
    data['districtId'] = districtId;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['status'] = status;
    return data;
  }
}

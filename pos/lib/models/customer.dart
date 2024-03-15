import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pos/constants/apis.dart';

class Customer {
  Customer({
    this.id,
    required this.name,
    required this.address,
    this.balance,
    this.remarks,
    this.createDate,
    this.updateDate,
    this.bizId,
  });

  late final int? id;
  late final String name;
  late final String address;
  late final int? balance;
  late final String? remarks;
  late final String? createDate;
  late final String? updateDate;
  late final String? bizId;

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

class SaleOrder {
  SaleOrder({
    this.id,
    this.soserial,
    this.billAmount,
    this.billPaid,
    this.discount,
    this.balance,
    this.prevBalance,
    this.date,
    this.saleReturn,
    this.customerId,
    this.sodid,
    this.saleOrderAmount,
    this.saleReturnAmount,
    this.saleOrderQty,
    this.saleReturnQty,
    this.profit,
    this.paymentMethod,
    this.paymentDetail,
    this.remarks,
    this.remarks2,
    this.employeeId,
    this.sODs,
  });

  late String? id;
  late int? soserial;
  late double? billAmount;
  late double? billPaid;
  late double? discount;
  late double? balance;
  late double? prevBalance;
  late String? date;
  late bool? saleReturn;
  late int? customerId;
  late int? sodid;
  late double? saleOrderAmount;
  late double? saleReturnAmount;
  late double? saleOrderQty;
  late double? saleReturnQty;
  late double? profit;
  late double? paymentMethod;
  late double? paymentDetail;
  late String? remarks;
  late String? remarks2;
  late String? employeeId;
  late List<SODs>? sODs;

  SaleOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    soserial = json['soserial'];
    billAmount = json['billAmount'];
    billPaid = json['billPaid'];
    discount = json['discount'];
    balance = json['balance'];
    prevBalance = json['prevBalance'];
    date = json['date'] ?? '';
    saleReturn = json['saleReturn'];
    customerId = json['customerId'];
    sodid = json['sodid'];
    saleOrderAmount = json['saleOrderAmount'];
    saleReturnAmount = json['saleReturnAmount'];
    saleOrderQty = json['saleOrderQty'];
    saleReturnQty = json['saleReturnQty'];
    profit = json['profit'];
    paymentMethod = json['paymentMethod'];
    paymentDetail = json['paymentDetail'];
    remarks = json['remarks'] ?? '';
    remarks2 = json['remarks2'] ?? '';
    employeeId = json['employeeId'] ?? '';
    sODs = List.from(json['sODs']).map((e) => SODs.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['soserial'] = soserial;
    data['billAmount'] = billAmount;
    data['billPaid'] = billPaid;
    data['discount'] = discount;
    data['balance'] = balance;
    data['prevBalance'] = prevBalance;
    data['date'] = date;
    data['saleReturn'] = saleReturn;
    data['customerId'] = customerId;
    data['sodid'] = sodid;
    data['saleOrderAmount'] = saleOrderAmount;
    data['saleReturnAmount'] = saleReturnAmount;
    data['saleOrderQty'] = saleOrderQty;
    data['saleReturnQty'] = saleReturnQty;
    data['profit'] = profit;
    data['paymentMethod'] = paymentMethod;
    data['paymentDetail'] = paymentDetail;
    data['remarks'] = remarks;
    data['remarks2'] = remarks2;
    data['employeeId'] = employeeId;
    data['sODs'] = sODs?.map((e) => e.toJson()).toList();
    return data;
  }
}

class SODs {
  SODs({
    this.flag,
    this.auto,
    this.soid,
    this.sodid,
    this.productId,
    this.productName,
    this.openingStock,
    this.quantity,
    this.salePrice,
    this.purchasePrice,
    this.perPack,
    this.isPack,
    this.saleType,
    this.profit,
    this.remarks,
  });

  late int? flag;
  late int? auto;
  late String? soid;
  late int? sodid;
  late int? productId;
  late String? productName;
  late double? openingStock;
  late int? quantity;
  late double? salePrice;
  late double? purchasePrice;
  late double? perPack;
  late bool? isPack;
  late bool? saleType;
  late double? profit;
  late String? remarks;

  SODs.fromJson(Map<String, dynamic> json) {
    auto = json['auto'];
    soid = json['soid'];
    sodid = json['sodid'];
    productId = json['productId'];
    openingStock = json['openingStock'];
    quantity = json['quantity'];
    salePrice = json['salePrice'];
    purchasePrice = json['purchasePrice'];
    perPack = json['perPack'];
    isPack = json['isPack'];
    saleType = json['saleType'];
    profit = json['profit'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['auto'] = auto;
    data['soid'] = soid;
    data['sodid'] = sodid;
    data['productId'] = productId;
    data['openingStock'] = openingStock;
    data['quantity'] = quantity;
    data['salePrice'] = salePrice;
    data['purchasePrice'] = purchasePrice;
    data['perPack'] = perPack;
    data['isPack'] = isPack;
    data['saleType'] = saleType;
    data['profit'] = profit;
    data['remarks'] = remarks;
    return data;
  }
}

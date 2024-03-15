class Product {
  Product({
     this.id,
    required this.name,
    this.purchasePrice,
     this.salePrice,
     this.stock,
     this.perPack,
     this.totalPiece,
     this.saleable,
     this.rackPosition,
     this.supplierId,
     this.image,
     this.remarks,
     this.barCode,
     this.reOrder,
     this.locationId,
     this.categoryId,
     this.createDate,
     this.updateDate,
  });
  late final int? id;
  late final String name;
  late final double? purchasePrice;
  late final double? salePrice;
  late final double? stock;
  late final int? perPack;
  late final double? totalPiece;
  late final bool? saleable;
  late final String? rackPosition;
  late final int? supplierId;
  late final String? image;
  late final String? remarks;
  late final String? barCode;
  late final int? reOrder;
  late final int? locationId;
  late final int? categoryId;
  late final String? createDate;
  late final String? updateDate;

  Product.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'] ?? '';
    purchasePrice = json['purchasePrice'];
    salePrice = json['salePrice'];
    stock = json['stock'];
    perPack = json['perPack'];
    totalPiece = json['totalPiece'];
    saleable = json['saleable'];
    rackPosition = json['rackPosition']?? '';
    supplierId = json['supplierId'];
    image = json['image']?? '';
    remarks = json['remarks']?? '';
    barCode = json['barCode']?? '';
    reOrder = json['reOrder'];
    locationId = json['locationId'];
    categoryId = json['categoryId'];
    createDate = json['createDate'] ?? '';
    updateDate = json['updateDate'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['purchasePrice'] = purchasePrice;
    data['salePrice'] = salePrice;
    data['stock'] = stock;
    data['perPack'] = perPack;
    data['totalPiece'] = totalPiece;
    data['saleable'] = saleable;
    data['rackPosition'] = rackPosition;
    data['supplierId'] = supplierId;
    data['image'] = image;
    data['remarks'] = remarks;
    data['barCode'] = barCode;
    data['reOrder'] = reOrder;
    data['locationId'] = locationId;
    data['categoryId'] = categoryId;
    data['createDate'] = createDate;
    data['updateDate'] = updateDate;
    return data;
  }
}
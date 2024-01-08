class product {
  String? name;
  String? parcode;
  int? price;
  String? descrption;
  int? stok;
  String? rate;
  String? proimage;
  String? type;
  CompanyId? companyId;

  product(
      {this.name,
      this.parcode,
      this.price,
      this.descrption,
      this.stok,
      this.rate,
      this.proimage,
      this.type,
      this.companyId});

  product.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    parcode = json['parcode'];
    price = json['price'];
    descrption = json['descrption'];
    stok = json['stok'];
    rate = json['rate'];
    proimage = json['proimage'];
    type = json['Type'];
    companyId = json['companyId'] != null
        ? new CompanyId.fromJson(json['companyId'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['parcode'] = this.parcode;
    data['price'] = this.price;
    data['descrption'] = this.descrption;
    data['stok'] = this.stok;
    data['rate'] = this.rate;
    data['proimage'] = this.proimage;
    data['Type'] = this.type;
    if (this.companyId != null) {
      data['companyId'] = this.companyId!.toJson();
    }
    return data;
  }
}

class CompanyId {
  String? oid;

  CompanyId({this.oid});

  CompanyId.fromJson(Map<String, dynamic> json) {
    oid = json['$oid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$oid'] = this.oid;
    return data;
  }
}

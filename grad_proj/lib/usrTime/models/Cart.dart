class cart {
  String? proBarCode;
  int? proPrice;
  int? count;
  String? userName;
  CompanyId? companyId;
  String? cartCode;

  cart(
      {this.proBarCode,
      this.proPrice,
      this.count,
      this.userName,
      this.companyId,
      this.cartCode});

  cart.fromJson(Map<String, dynamic> json) {
    proBarCode = json['ProBarCode'];
    proPrice = json['ProPrice'];
    count = json['Count'];
    userName = json['UserName'];
    companyId = json['companyId'] != null
        ? new CompanyId.fromJson(json['companyId'])
        : null;
    cartCode = json['CartCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProBarCode'] = this.proBarCode;
    data['ProPrice'] = this.proPrice;
    data['Count'] = this.count;
    data['UserName'] = this.userName;
    if (this.companyId != null) {
      data['companyId'] = this.companyId!.toJson();
    }
    data['CartCode'] = this.cartCode;
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
class store {
  String? userFirstName;
  String? userLastName;
  String? email;
  String? password;
  String? city;
  bool? isExpert;

  store(
      {this.userFirstName,
      this.userLastName,
      this.email,
      this.password,
      this.city,
      this.isExpert});

  store.fromJson(Map<String, dynamic> json) {
    userFirstName = json['userFirstName'];
    userLastName = json['userLastName'];
    email = json['email'];
    password = json['password'];
    city = json['city'];
    isExpert = json['isExpert'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userFirstName'] = this.userFirstName;
    data['userLastName'] = this.userLastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['city'] = this.city;
    data['isExpert'] = this.isExpert;
    return data;
  }
}
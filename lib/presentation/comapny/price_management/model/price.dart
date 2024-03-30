class Price {
  String? uid ;
  String? companyId ;
  double? price ;
  String? district ;

  Price(this.price, this.district,{this.uid,this.companyId});

  Price.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    price = json['price'];
    district = json['district'];
    companyId = json['companyId'];
  }

  toJson() {
    return {
      'uid': uid,
      'price': price,
      'district': district,
      'companyId': companyId
    };
  }
}
class Company {
   String? companyId;
   String? name;
   String? email;
   String? phone;
   bool blocked = false;

  Company({
      this.companyId,
    required this.name,
    required this.email,
    required this.phone,
   });

  Company.fromJson(Map<String, dynamic> json) {
    companyId = json['companyId'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    blocked = json['blocked']??false;
   }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyId'] = this.companyId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['blocked'] = this.blocked;
     return data;
  }

}

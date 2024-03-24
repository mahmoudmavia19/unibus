class UserModel {
   String? name;
   String? userId;
   String? address;
   String? phone;
   String? email;
   bool blocked = false;

  UserModel({
    required this.name,
      this.userId,
      this.address,
    required this.phone,
    required this.email,
   });

   UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userId = json['userId'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    blocked = json['blocked']??false;
   }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['userId'] = this.userId;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['blocked'] = this.blocked;
     return data;
  }

}

class UserModel {
  String? userId;
  String? email;
  String? username;
  String? phoneNumber;
  String? shopName;
  String? pic;

  UserModel(
      {this.userId,
      this.email,
      this.username,
      this.pic,
      this.shopName,
      this.phoneNumber,
      });

  UserModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    userId = map['uid'];
    email = map['Email'];
    username = map['Name'];
    pic = map['Image'];
    phoneNumber = map['Phone'];
    shopName = map['ShopName'];
  }

  toJson() {
    return {
      'uid': userId,
      'Email': email,
      'Name': username,
      'Image': pic,
      'Phone': phoneNumber,
      'ShopName': shopName,
    };
  }
}

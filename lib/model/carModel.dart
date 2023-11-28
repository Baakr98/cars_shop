class CarModel {
  String? user;
  String? plateNumber; 
  String? carName;
  String? carType;
  String? pic;

  CarModel({this.user, this.plateNumber, this.carName, this.pic,this.carType});

  CarModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    user = map['user'];
    plateNumber = map['plateNumber'];
    carName = map['carName'];
    pic = map['pic'];
    carType = map['carType'];
  }

  toJson() {
    return {
      'user': user,
      'plateNumber': plateNumber,
      'carName': carName,
      'pic': pic,
      'carType': carType,
    };
  }
}
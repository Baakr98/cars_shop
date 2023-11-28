import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Future<Bill>>> getBills({String? id, bool? isUser}) async {
  final billsCollection = id==null ? FirebaseFirestore.instance.collection('Bill'):FirebaseFirestore.instance.collection('Bill').where(isUser!?'userid':'salerid',isEqualTo:  id);
  final billsSnapshots = await billsCollection.get();
  var parts;
  final bills = billsSnapshots.docs.map((billDoc) async{
    final partsCollection = billDoc.reference.collection('Parts');
    final partsSnapshots = await partsCollection.get();
    parts = partsSnapshots.docs.map((partDoc) {
      final partData = partDoc.data();
      return Part.fromJson(partData);
    }).toList();

    final billData = billDoc.data();
    return Bill.fromJson(billData, parts);
  }).toList();

  return bills;
}

class Bill {
   String? salerid;
   String? userid;
   String? dateOfBill;
   String? pic;
   List<Part> parts;
   Bill({this.salerid, this.userid, this.dateOfBill, this.pic,required this.parts});
  Bill.fromJson(Map<dynamic, dynamic> map, this.parts) {
    if (map == null) {
      return;
    }
    salerid = map['salerid'];
    userid = map['userid'];
    dateOfBill = map['dateOfBill'];
    pic = map['BillPic'];
  }
}

class Part {
 String? partName;
 String? dateOfPurchase;
 String? insurance;
 String? price;

  Part({required this.price,required this.partName,required this.dateOfPurchase,required this.insurance});
 Part.fromJson(Map<dynamic, dynamic> map) {
   if (map == null) {
     return;
   }
   partName = map['partName'];
   dateOfPurchase = map['dateOfPurchase'];
   insurance = map['insurance'];
   price = map['price'];
 }
}
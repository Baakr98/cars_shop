import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../model/billModelTest.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final billsCollection = FirebaseFirestore.instance.collection('Bill');
  ReportsBloc() : super(ReportsInitial()) {
    on<GetReportsEvent>(getReports);
  }

  FutureOr<void> getReports(GetReportsEvent event, Emitter<ReportsState> emit) async {
    try {
      emit(GetReportsLoadingState());
      final snapshot = await billsCollection.where('salerid',isEqualTo: event.userId).get();
      if (snapshot.docs.isNotEmpty) {
        List<Bill>bills=[];
        for(int i = 0; i<snapshot.docs.length;i++){
          final partsCollection = await FirebaseFirestore.instance.collection('Bill/${snapshot.docs[i].id}/Parts').get();
          List<Part>parts=[];
          for(int j = 0; j<partsCollection.docs.length;j++){
            parts.add(Part.fromJson(partsCollection.docs[j].data()));
          }
          bills.add(Bill.fromJson(snapshot.docs[i].data(),parts));
        }
        emit(GetReportsSuccessState(bills: bills));
      } else {
        emit(GetReportsFailureState(message: 'You don\'t have reports yet'));
      }
    } on FirebaseException catch (e) {
      emit(GetReportsFailureState(message: e.code));
    }
  }
}
// final billsCollection = id==null ? FirebaseFirestore.instance.collection('Bill'):FirebaseFirestore.instance.collection('Bill').where(isUser!?'userid':'salerid',isEqualTo:  id);
// final billsSnapshots = await billsCollection.get();
// var parts;
// final bills = billsSnapshots.docs.map((billDoc) async{
//   final partsCollection = billDoc.reference.collection('Parts');
//   final partsSnapshots = await partsCollection.get();
//   parts = partsSnapshots.docs.map((partDoc) {
//     final partData = partDoc.data();
//     return Part.fromJson(partData);
//   }).toList();
//
//   final billData = billDoc.data();
//   return Bill.fromJson(billData, parts);
// }).toList();
//
// return bills;
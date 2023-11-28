import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'add_report_event.dart';
part 'add_report_state.dart';

class AddReportBloc extends Bloc<AddReportEvent, AddReportState> {
  final ins=FirebaseFirestore.instance;
  final partName = TextEditingController();
  final insurance = TextEditingController();
  final price = TextEditingController();
  String? dateOfPurchase;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AddReportBloc() : super(AddReportInitial()) {
    on<AddPartEvent>(addPart);
    on<DeleteBillEvent>(deleteBill);
  }

  FutureOr<void> addPart(AddPartEvent event, Emitter<AddReportState> emit) async {
    try{
      emit(AddPartLoadingState());
      await ins.collection('Bill/${event.billId}/Parts').add({
        'dateOfPurchase': event.dateOfPurchase,
        'insurance': event.insurance,
        'partName': event.partName,
        'price': event.price,
      });
      partName.clear();
      price.clear();
      insurance.clear();
      emit(AddPartSuccessState());
    }on FirebaseException catch(e){
      emit(AddPartFailureState(message: e.code));
    }
  }

  FutureOr<void> deleteBill(DeleteBillEvent event, Emitter<AddReportState> emit) async {
    try{
      emit(DeleteBillLoadingState());
      await ins.collection('Bill').doc(event.billId).delete();
      emit(DeleteBillSuccessState());
    }on FirebaseException catch(e){
      emit(DeleteBillFailureState(message: e.code));
    }
  }
}

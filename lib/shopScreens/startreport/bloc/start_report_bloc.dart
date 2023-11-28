import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cars_shop/model/billModelTest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';

import '../../../core/cache_helper.dart';
import '../../../core/image_picker.dart';
import '../../../model/userModel.dart';

part 'start_report_event.dart';
part 'start_report_state.dart';

class StartReportBloc extends Bloc<StartReportEvent, StartReportState> {
  final usersCollection=FirebaseFirestore.instance.collection('ShopUser');
  final reportsCollection=FirebaseFirestore.instance.collection('Bill');
  final imageIns=FirebaseStorage.instance.ref();
  List<String> user = [];
  List<String> userid = [];
  File? imageFile;
  AppAlert imagePicker = AppAlert.init;
  String? selectedUserId, dateOfBill, billId, userName, imageName,imagePath;
  StartReportBloc() : super(StartReportInitial()) {
    on<GetUsersEvent>(getUsers);
    on<StartNewReportEvent>(startNewReport);
    on<UploadImageEvent>(uploadImage);
  }

  FutureOr<void> getUsers(GetUsersEvent event, Emitter<StartReportState> emit) async {
    try {
      emit(GetUsersLoadingState());
      final snapshot = await usersCollection.get();
      if (snapshot.docs.isNotEmpty) {
        List<UserModel>users=[];
        for(int i = 0; i<snapshot.docs.length;i++){
          users.add(UserModel.fromJson(snapshot.docs[i].data()));
        }
        emit(GetUsersSuccessState(users: users));
      } else {
        emit(GetUsersFailureState(message: 'There is no users'));
      }
    }on FirebaseException catch (e) {
      emit(GetUsersFailureState(message: e.code));
    }
  }

  FutureOr<void> startNewReport(StartNewReportEvent event, Emitter<StartReportState> emit) async {
    try {
      emit(StartNewReportLoadingState());
      final data=await reportsCollection.add({
        'BillPic': event.pic,
        'dateOfBill': event.dateOfBill,
        'salerid': CacheHelper.getId(),
        'userid': event.userId,
      });
      emit(StartNewReportSuccessState(billId: data.id ));
    } on FirebaseException catch (e) {
      emit(StartNewReportFailureState(message: e.code));
    }
  }

  FutureOr<void> uploadImage(UploadImageEvent event, Emitter<StartReportState> emit) async {
    try{
      emit(UploadImageLoadingState());
      final imageRef=imageIns.child('${DateTime.now()} ${event.imageName}');
      await imageRef.putFile(event.imageFile);
      final storageRef=await imageRef.getDownloadURL();
      emit(UploadImageSuccessState(imagePath: storageRef));
    }on FirebaseException catch(e){
      emit(UploadImageFailureState(message: e.code));
    }
  }
}

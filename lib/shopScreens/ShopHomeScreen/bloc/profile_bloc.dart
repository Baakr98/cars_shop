import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cars_shop/model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../core/cache_helper.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final usersCollection=FirebaseFirestore.instance.collection('user');
  ProfileBloc() : super(ProfileInitial()) {
    on<GetUserEvent>(getUser);
    on<LogOutEvent>(logOut);
  }

  FutureOr<void> getUser(GetUserEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(GetUserLoadingState());
      final snapshot = await usersCollection.where('uid',isEqualTo: event.userId).get();
      if (snapshot.docs.isNotEmpty) {
        emit(GetUserSuccessState(user:UserModel.fromJson(snapshot.docs[0].data())));
      } else {
        emit(GetUserFailureState(message: 'There is no users'));
      }
    }on FirebaseException catch (e) {
      emit(GetUserFailureState(message: e.code));
    }
  }

  FutureOr<void> logOut(LogOutEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(LogOutLoadingState());
      final credential = await FirebaseAuth.instance.signOut();
      CacheHelper.clear();
      emit(LogOutSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(LogOutFailureState(message:e.code));
    }
  }
}

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../core/cache_helper.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final email=TextEditingController();
  final password=TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginBloc() : super(LoginInitial()) {
    on<LoginNowEvent>(loginNow);
  }

  FutureOr<void> loginNow(LoginNowEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginNowLoadingState());
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email,
          password: event.password
      );
      final data=await FirebaseFirestore.instance.collection('ShopUser').where('uid',isEqualTo:credential.user!.uid ).get();
      if(data.docs.isNotEmpty){
        CacheHelper.clear();
        CacheHelper.saveId(credential.user!.uid);
        CacheHelper.saveEmail(credential.user!.email!);
        emit(LoginNowSuccessState());
      }else{
	await FirebaseAuth.instance.signOut();
        emit(LoginNowFailureState(message:'user not found'));
      }
    } on FirebaseAuthException catch (e) {
      emit(LoginNowFailureState(message:e.code));
    }
  }
}

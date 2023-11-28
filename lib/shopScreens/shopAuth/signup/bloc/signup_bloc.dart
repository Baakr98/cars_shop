import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final name=TextEditingController();
  final shopName=TextEditingController();
  final email=TextEditingController();
  final password=TextEditingController();
  final phoneNumber=TextEditingController();
  final userCollection=FirebaseFirestore.instance.collection('ShopUser');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  SignupBloc() : super(SignupInitial()) {
    on<SignUpNowEvent>(signupNow);
  }

  FutureOr<void> signupNow(SignUpNowEvent event, Emitter<SignupState> emit) async {
    try {
      emit(SignupNowLoadingState());
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      userCollection.add({
          "Name": event.name,
          "Phone": event.phone,
          "Email": event.email,
          "Image": "",
          "uid": credential.user!.uid,
          "ShopName": event.shopName,
      });
      emit(SignupNowSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(SignupNowFailureState(message:e.code));
    }
  }
}

// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/feature/auth/presentation/view_model/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  login(String email, String password) async {
    emit(AuthLodingState());
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(AuthSuccesState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthFailerState(error: 'لا يوجد حساب علي هذا الايميل'));
      } else if (e.code == 'wrong-password') {
        emit(AuthFailerState(error: 'كلمة السر التي ادخلتها غير صحيحة'));
      } else {
        emit(AuthFailerState(error: 'حدثت مشكلة في تسجيل الدخول حاول لاحقاً'));
      }
    }

    resisterPatient(String name, String email, String password) async {
      emit(AuthLodingState());
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        User user = credential.user!;
        await user.updateDisplayName(name);

        FirebaseFirestore.instance.collection('Patient').doc(user.uid).set({
          'name': name,
          'image': null,
          'age': null,
          'email': email,
          'phone': null,
          'bio': null,
          'city': null,
        }, SetOptions(merge: true));
        emit(AuthSuccesState());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          emit(AuthFailerState(error: 'كلمة السر التي ادخلتها ضعيفة جدا'));
        } else if (e.code == 'email-already-in-use') {
          emit(AuthFailerState(error: 'يوجد حساب بالفعل علي هذا الايميل'));
        } else {
          emit(AuthFailerState(error: e.toString()));
        }
      }
    }
  }

  resisterDoctore(String name, String email, String password) async {
    emit(AuthLodingState());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = credential.user!;
      await user.updateDisplayName(name);

      FirebaseFirestore.instance.collection('Doctor').doc(user.uid).set({
        'name': name,
        'image': null,
        'specialization': null,
        'rating': null,
        'email': user.email,
        'phone1': null,
        'phone2': null,
        'bio': null,
        'openHour': null,
        'closeHour': null,
        'address': null,
      }, SetOptions(merge: true));
      emit(AuthSuccesState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthFailerState(error: 'كلمة السر التي ادخلتها ضعيفة جدا'));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthFailerState(error: 'يوجد حساب بالفعل علي هذا الايميل'));
      } else {
        emit(AuthFailerState(error: e.toString()));
      }
    }
  }
}

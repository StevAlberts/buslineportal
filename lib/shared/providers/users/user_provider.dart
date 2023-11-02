import 'package:buslineportal/shared/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
Stream<UserRequestModel?> streamUserRequest(
    StreamUserRequestRef ref,
    String uid,
    ) {
  final collection = FirebaseFirestore.instance.collection('requests');

  var userStream = collection.doc(uid)
      .snapshots()
      .map((snapshot) => snapshot)
      .map((doc) => UserRequestModel.fromFirestore(doc));

  return userStream;
}
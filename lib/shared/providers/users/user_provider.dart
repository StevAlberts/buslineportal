import 'package:buslineportal/shared/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/user_request_model.dart';

part 'user_provider.g.dart';

@riverpod
Stream<UserRequestModel?> streamUserRequest(
  StreamUserRequestRef ref,
  String? uid,
) {
  final collection = FirebaseFirestore.instance.collection('requests');

  if (uid != null) {
    var userStream = collection
        .doc(uid)
        .snapshots()
        .map((snapshot) => snapshot)
        .map((doc) => UserRequestModel.fromFirestore(doc));

    return userStream;
  }

  return const Stream.empty();
}

@riverpod
Stream<UserModel?> streamCurrentUser(
  StreamCurrentUserRef ref,
  String? uid,
) {
  final collection = FirebaseFirestore.instance.collection('users');

  if (uid != null) {
    var userStream = collection
        .doc(uid)
        .snapshots()
        .map((snapshot) => snapshot)
        .map((doc) => UserModel.fromFirestore(doc));

    return userStream;
  }

  return const Stream.empty();
}

@riverpod
Stream<List<UserModel>?> streamUserManagers(
  StreamUserManagersRef ref,
  String companyId,
) {
  final collection = FirebaseFirestore.instance.collection('users');

  var userStream = collection
      .where('companyId', isEqualTo: companyId)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList());

  return userStream;
}

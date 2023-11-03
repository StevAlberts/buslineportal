import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/company_model.dart';
import '../../models/trip_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'company_provider.g.dart';

var companyCollection = FirebaseFirestore.instance.collection('companies');

@riverpod
Stream<Company?> streamCompany(
    StreamCompanyRef ref,
    String companyId,
    ) {
  var ticketStream = companyCollection
      .doc(companyId)
      .snapshots()
      .map((snapshot) => Company.fromJson(snapshot.data()));

  return ticketStream;
}
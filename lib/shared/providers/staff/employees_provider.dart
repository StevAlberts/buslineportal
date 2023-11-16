import 'package:buslineportal/shared/models/staff_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employees_provider.g.dart';

var employeesCollection = FirebaseFirestore.instance.collection('employees');

@riverpod
Stream<List<Staff>> streamCompanyEmployees(
    StreamCompanyEmployeesRef ref,
    String companyId,
    ) {

  var employeeStream = employeesCollection
      .where('companyId', isEqualTo: companyId)
      .orderBy('timestamp', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
      .map((doc) => Staff.fromJson(doc.data()))
      .toList());

  return employeeStream;
}

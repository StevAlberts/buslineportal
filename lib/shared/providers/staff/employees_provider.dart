import 'package:buslineportal/shared/models/employee_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employees_provider.g.dart';

var employeesCollection = FirebaseFirestore.instance.collection('employees');

@riverpod
Stream<List<Employee>> streamAllEmployees(
    StreamAllEmployeesRef ref,
    String companyId,
    ) {

  var employeeStream = employeesCollection
      .where('companyId', isEqualTo: companyId).orderBy('timestamp', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
      .map((doc) => Employee.fromJson(doc.data()))
      .toList());

  return employeeStream;
}
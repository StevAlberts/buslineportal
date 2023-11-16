import 'package:buslineportal/shared/models/company_model.dart';
import 'package:buslineportal/shared/models/staff_model.dart';
import 'package:buslineportal/shared/models/staff_details_model.dart';
import 'package:buslineportal/shared/models/trip_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../shared/models/fleet_model.dart';

class DatabaseService {
  final usersCollection = FirebaseFirestore.instance.collection('users');
  final requestsCollection = FirebaseFirestore.instance.collection('requests');
  final employeeCollection = FirebaseFirestore.instance.collection('employees');
  final tripsCollection = FirebaseFirestore.instance.collection('trips');
  final companiesCollection =
      FirebaseFirestore.instance.collection('companies');
  final passengerTicketsCollection =
      FirebaseFirestore.instance.collection('passengerTickets');
  final luggageTicketsCollection =
      FirebaseFirestore.instance.collection('luggageTickets');

  // create employee
  Future<void> createEmployee(Staff employee) async {
    final firestore = FirebaseFirestore.instance;
    final employeeRef = employeeCollection.doc(employee.id);
    await employeeRef.set(employee.toJson());
  }

  // update employee
  Future<void> updateEmployee(Staff employee) async {
    final firestore = FirebaseFirestore.instance;
    final employeeRef = employeeCollection.doc(employee.id);
    await employeeRef.update(employee.toJson());
  }

  Future<void> acceptEmployeeRequest(
    String employeeId,
    String deviceId,
    String deviceName,
  ) async {
    final employeeRef = employeeCollection.doc(employeeId);
    await employeeRef.update({
      "deviceId": deviceId,
      "deviceName": deviceName,
    });
  }

  Future<void> removeEmployeeRequest(String companyId, Map data) async {
    final employeeRef = companiesCollection.doc(companyId);

    await employeeRef.update(
      {
        "requests": FieldValue.arrayRemove([data])
      },
    );
  }

  // create employee
  Future<void> deleteEmployee(String employeeId) async {
    final firestore = FirebaseFirestore.instance;
    final employeeRef = employeeCollection.doc(employeeId);
    await employeeRef.delete();
  }

  // create trip
  Future<void> createTrip(Trip trip) async {
    final firestore = FirebaseFirestore.instance;
    final tripRef = firestore.collection('trips').doc(trip.id);
    await tripRef.set(trip.toJson());
  }

  Future<void> createStaffTrips(List<StaffDetail> staffs, String tripId) async {
    final firestore = FirebaseFirestore.instance;
    for (var staff in staffs){
      var trip = {
        "id":tripId,
        "role":staff.role,
      };
      await firestore.collection('employees').doc(staff.staffId).update(
        {
          "trips":FieldValue.arrayUnion([trip])
        }
      );
    }
  }

  // create trip
  Future<void> updateTrip(Trip trip) async {
    final firestore = FirebaseFirestore.instance;
    final tripRef = firestore.collection('trips').doc(trip.id);
    await tripRef.update(trip.toJson());
  }

  // create trip
  Future<void> createTrip0(Trip trip) async {
    final firestore = FirebaseFirestore.instance;
    final tripRef = firestore.collection('trips').doc(trip.id);
    await tripRef.set(trip.toJson());
  }

  // update route
  Future<void> createRoute(String dest, String companyId) async {
    final firestore = FirebaseFirestore.instance;
    final companyRef = firestore.collection('companies').doc(companyId);
    await companyRef.update(
      {
        "destinations": FieldValue.arrayUnion([dest.toLowerCase()])
      },
    );
  }

  // remove route
  Future<void> deleteRoute(String dest, String companyId) async {
    final firestore = FirebaseFirestore.instance;
    final companyRef = firestore.collection('companies').doc(companyId);
    await companyRef.update(
      {
        "destinations": FieldValue.arrayRemove([dest])
      },
    );
  }

  // update route
  Future<void> createFleet(Fleet fleet, String companyId) async {
    final firestore = FirebaseFirestore.instance;
    final companyRef = firestore.collection('companies').doc(companyId);
    await companyRef.update(
      {
        "fleet": FieldValue.arrayUnion([fleet.toJson()])
      },
    );
  }

  // remove route
  Future<void> deleteFleet(Fleet fleet, String companyId) async {
    final firestore = FirebaseFirestore.instance;
    final companyRef = firestore.collection('companies').doc(companyId);
    await companyRef.update(
      {
        "fleet": FieldValue.arrayRemove([fleet.toJson()])
      },
    );
  }

  // create company
  Future<void> createCompanyProfile(Company company) async {
    final companyRef = companiesCollection.doc(company.id);
    await companyRef.set(company.toJson());
  }

// Query job assigned by manager for trip

  // Query bus information (no, company, contacts, busno, start, destination, date

  // Create passenger

  // Save passenger details

  // Query passengers

  // Query passenger details

  //...
}

DatabaseService databaseService = DatabaseService();

import 'package:buslineportal/shared/models/company.dart';

Company dummyCompany = Company(
  legalName: "Maribou Transport Co. Ltd.",
  registrationNumber: "123456789",
  businessType: "Transportation",
  businessAddress: "123 Main Street",
  businessPhone: "123-456-7890",
  businessEmail: "maribou@gmail.com",
  websiteURL: "https://mariboutransport.com",
  taxIdentificationNumber: "123456789",
  logoURL:
      "https://plus.unsplash.com/premium_photo-1682216872195-0bfacc36b02c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80",
);

final List<Map<String, dynamic>> dummyTrips = [
  {
    "id": "1",
    "date": DateTime.now(),
    "busNumber": "1234",
    "route": "Kampala - Gulu",
    "departureTime": DateTime.now(),
    "capacity": 50,
  },
  {
    "id": "2",
    "date": DateTime.now(),
    "busNumber": "1234",
    "route": "Kampala - Gulu",
    "departureTime": DateTime.now(),
    "capacity": 50,
  },
  {
    "id": "3",
    "date": DateTime.now(),
    "busNumber": "1234",
    "route": "Kampala - Gulu",
    "departureTime": DateTime.now(),
    "capacity": 50,
  },
  {
    "id": "4",
    "date": DateTime.now(),
    "busNumber": "1234",
    "route": "Kampala - Gulu",
    "departureTime": DateTime.now(),
    "capacity": 50,
  },
  {
    "id": "5",
    "date": DateTime.now(),
    "busNumber": "1234",
    "route": "Kampala - Gulu",
    "departureTime": DateTime.now(),
    "capacity": 50,
  },
  {
    "id": "6",
    "date": DateTime.now(),
    "busNumber": "1234",
    "route": "Kampala - Gulu",
    "departureTime": DateTime.now(),
    "capacity": 50,
  },
  {
    "id": "7",
    "date": DateTime.now(),
    "busNumber": "1234",
    "route": "Kampala - Gulu",
    "departureTime": DateTime.now(),
    "capacity": 50,
  },
  {
    "id": "8",
    "date": DateTime.now(),
    "busNumber": "1234",
    "route": "Kampala - Gulu",
    "departureTime": DateTime.now(),
    "capacity": 50,
  },
  {
    "id": "9",
    "date": DateTime.now(),
    "busNumber": "1234",
    "route": "Kampala - Gulu",
    "departureTime": DateTime.now(),
    "capacity": 50,
  }
];
final List<Map<String, dynamic>> dummyTripsData = [
  {
    "id": "1",
    "date": DateTime.now(),
    "driver": "John Doe",
    "bus": "1234",
    "route": "Kampala - Gulu",
    "status": "In Progress",
    "departureTime": DateTime.now(),
    "arrivalTime": DateTime.now(),
    "capacity": 50,
    "duration": "4 hours",
  },
  {
    "id": "2",
    "date": DateTime.now(),
    "driver": "John Doe",
    "bus": "1234",
    "route": "Kampala - Gulu",
    "status": "In Progress",
    "departureTime": DateTime.now(),
    "arrivalTime": DateTime.now(),
    "capacity": 50,
    "duration": "4 hours",
  },
  {
    "id": "3",
    "date": DateTime.now(),
    "driver": "John Doe",
    "bus": "1234",
    "route": "Kampala - Gulu",
    "status": "In Progress",
    "departureTime": DateTime.now(),
    "arrivalTime": DateTime.now(),
    "capacity": 50,
    "duration": "4 hours",
  },
  {
    "id": "4",
    "date": DateTime.now(),
    "driver": "John Doe",
    "bus": "1234",
    "route": "Kampala - Gulu",
    "status": "In Progress",
    "departureTime": DateTime.now(),
    "arrivalTime": DateTime.now(),
    "capacity": 50,
    "duration": "4 hours",
  },
  {
    "id": "5",
    "date": DateTime.now(),
    "driver": "John Doe",
    "bus": "1234",
    "route": "Kampala - Gulu",
    "status": "In Progress",
    "departureTime": DateTime.now(),
    "arrivalTime": DateTime.now(),
    "capacity": 50,
    "duration": "4 hours",
  },
  {
    "id": "6",
    "date": DateTime.now(),
    "driver": "John Doe",
    "bus": "1234",
    "route": "Kampala - Gulu",
    "status": "In Progress",
    "departureTime": DateTime.now(),
    "arrivalTime": DateTime.now(),
    "capacity": 50,
    "duration": "4 hours",
  },
  {
    "id": "7",
    "date": DateTime.now(),
    "driver": "John Doe",
    "bus": "1234",
    "route": "Kampala - Gulu",
    "status": "In Progress",
    "departureTime": DateTime.now(),
    "arrivalTime": DateTime.now(),
    "capacity": 50,
    "duration": "4 hours",
  },
  {
    "id": "8",
    "date": DateTime.now(),
    "driver": "John Doe",
    "bus": "1234",
    "route": "Kampala - Gulu",
    "status": "Completed",
    "departureTime": DateTime.now(),
    "arrivalTime": DateTime.now(),
    "capacity": 50,
    "duration": "4 hours",
  },
  {
    "id": "9",
    "date": DateTime.now(),
    "driver": "John Doe",
    "bus": "1234",
    "route": "Kampala - Gulu",
    "status": "Completed",
    "departureTime": DateTime.now(),
    "arrivalTime": DateTime.now(),
    "capacity": 50,
    "duration": "4 hours",
  }
];

final List<String> dummyRoutes = [
  "Kampala - Gulu",
  "Kampala - Masaka",
  "Kampala - Jinja",
  "Kampala - Mbale",
];

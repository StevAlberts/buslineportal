import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Company {
  Company({
    required this.legalName,
    required this.registrationNumber,
    required this.businessType,
    required this.businessAddress,
    required this.businessPhone,
    required this.businessEmail,
    this.websiteURL,
    required this.taxIdentificationNumber,
    required this.logoURL,
  }) : id = uuid.v4();

  final String id;
  final String legalName;
  final String registrationNumber;
  final String businessType;
  final String businessAddress;
  final String businessPhone;
  final String businessEmail;
  final String? websiteURL;
  final String taxIdentificationNumber;
  final String logoURL;
}

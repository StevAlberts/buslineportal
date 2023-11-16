class StaffDetail {
  String? staffId;
  String? role;
  String? photoURL;
  String? firstName;
  String? lastName;
  String? gender;
  String? phone;

  StaffDetail({
    this.staffId,
    this.role,
    this.photoURL,
    this.firstName,
    this.lastName,
    this.gender,
    this.phone,
  });

  factory StaffDetail.fromJson(Map<String, dynamic>? json) => StaffDetail(
        staffId: json?["id"],
        role: json?["role"],
        photoURL: json?["photoURL"],
        firstName: json?["firstName"],
        lastName: json?["lastName"],
        gender: json?["gender"],
        phone: json?["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": staffId,
        "role": role,
        "photoURL": photoURL,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "phone": phone,
      };
}

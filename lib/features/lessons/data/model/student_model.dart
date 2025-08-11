import 'package:equatable/equatable.dart';

class StudentModel extends Equatable {
  final int id;
  final int mosqueId;
  final String firstName;
  final String lastName;
  final String phone;
  final String fatherPhone;
  final String birthDate;
  final String email;
  final String address;
  final String certificates;
  final String code;
  final String experiences;
  final int memorizedParts;
  final int roleId;
  final bool isSaveQuran;

  const StudentModel({
    this.id = 0,
    this.mosqueId = 0,
    this.firstName = '',
    this.lastName = '',
    this.phone = '',
    this.fatherPhone = '',
    this.birthDate = '',
    this.email = '',
    this.address = '',
    this.certificates = '',
    this.code = '',
    this.experiences = '',
    this.memorizedParts = 0,
    this.roleId = 0,
    this.isSaveQuran = false,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'] as int,
      mosqueId: json['mosque_id'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      phone: json['phone'] as String,
      fatherPhone: json['father_phone'] as String,
      birthDate: json['birth_date'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      certificates: json['certificates'] as String,
      code: json['code'] as String,
      experiences: json['experiences'] as String,
      memorizedParts: json['memorized_parts'] as int,
      roleId: json['role_id'] as int,
      isSaveQuran: json['is_save_quran'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mosque_id': mosqueId,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'father_phone': fatherPhone,
      'birth_date': birthDate,
      'email': email,
      'address': address,
      'certificates': certificates,
      'code': code,
      'experiences': experiences,
      'memorized_parts': memorizedParts,
      'role_id': roleId,
      'is_save_quran': isSaveQuran,
    };
  }

  @override
  List<Object?> get props => [
    id,
    mosqueId,
    firstName,
    lastName,
    phone,
    fatherPhone,
    birthDate,
    email,
    address,
    certificates,
    code,
    experiences,
    memorizedParts,
    roleId,
    isSaveQuran,
  ];
}
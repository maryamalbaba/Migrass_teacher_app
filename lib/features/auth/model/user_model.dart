import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final int mosqueId;
  final String birthDate;
  final bool isSaveQuran;
  final String phone;
  final String fatherPhone;
  final String address;
  final String certificates;
  final String experiences;
  final int memorizedParts;
  final int roleId;
  final String updatedAt;
  final String createdAt;
  final String codeUser;
  final String token;

  const UserModel({
    this.id = 0,
    this.email = '',
    this.firstName = '',
    this.lastName = '',
    this.mosqueId = 0,
    this.birthDate='',
    this.isSaveQuran = false,
    this.phone = '',
    this.fatherPhone = '',
    this.address = '',
    this.certificates = '',
    this.experiences = '',
    this.memorizedParts = 0,
    this.roleId = 0,
    this.updatedAt='',
    this.createdAt='',
    this.codeUser = '',
    this.token = '',
  });

factory UserModel.fromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['id'] ?? 0,
    email: json['email'] ?? '',
    firstName: json['first_name'] ?? '',
    lastName: json['last_name'] ?? '',
    mosqueId: json['mosque_id'] ?? 0,
    birthDate: json['birth_date'] ?? '',
    isSaveQuran: json['is_save_quran'] ?? false,
    phone: json['phone'] ?? '',
    fatherPhone: json['father_phone'] ?? '',
    address: json['address'] ?? '',
    certificates: json['certificates'] ?? '',
    experiences: json['experiences'] ?? '',
    memorizedParts: json['memorized_parts'] ?? 0,
    roleId: json['role_id'] ?? 0,
    updatedAt: json['updated_at'] ?? '',
    createdAt: json['created_at'] ?? '',
    codeUser: json['code_user'] ?? '',
    token: json['token'] ?? '',
  );
}


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'mosque_id': mosqueId,
      'birth_date': birthDate,
      'is_save_quran': isSaveQuran,
      'phone': phone,
      'father_phone': fatherPhone,
      'address': address,
      'certificates': certificates,
      'experiences': experiences,
      'memorized_parts': memorizedParts,
      'role_id': roleId,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'code_user': codeUser,
      'token': token,
    };
  }

  @override
  List<Object?> get props => [
    id,
    email,
    firstName,
    lastName,
    mosqueId,
    birthDate,
    isSaveQuran,
    phone,
    fatherPhone,
    address,
    certificates,
    experiences,
    memorizedParts,
    roleId,
    updatedAt,
    createdAt,
    codeUser,
    token,
  ];
}
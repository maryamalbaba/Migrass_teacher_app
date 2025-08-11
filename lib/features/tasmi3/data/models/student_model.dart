// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StudentModel {
            
String first_name;
String last_name; 
num id;
  StudentModel({
    required this.first_name,
    required this.last_name,
    required this.id,
  });
            

  StudentModel copyWith({
    String? first_name,
    String? last_name,
  }) {
    return StudentModel(
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_name': first_name,
      'last_name': last_name,
      'id': id,

    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      first_name: map['first_name']?.toString() ??" ",
      last_name: map['last_name']?.toString()?? " ",
      id: map['id']?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentModel.fromJson(String source) => StudentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'StudentModel(first_name: $first_name, last_name: $last_name , id:$id)';

  @override
  bool operator ==(covariant StudentModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.first_name == first_name &&
      other.last_name == last_name
      &&
      other.id==id;
      

  }

  @override
  int get hashCode => first_name.hashCode ^ last_name.hashCode;
}

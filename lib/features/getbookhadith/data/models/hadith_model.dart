// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HadithModel {
  num id;
  String name;
  num hadith_num;
  HadithModel({
    required this.id,
    required this.name,
    required this.hadith_num,
  });

  HadithModel copyWith({
    num? id,
    String? name,
    num? hadith_num,
  }) {
    return HadithModel(
      id: id ?? this.id,
      name: name ?? this.name,
      hadith_num: hadith_num ?? this.hadith_num,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'hadith_num': hadith_num,
    };
  }

  factory HadithModel.fromMap(Map<String, dynamic> map) {
    return HadithModel(
      id: map['id'] as num,
      name: map['name'] as String,
      hadith_num: map['hadith_num'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory HadithModel.fromJson(String source) => HadithModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'HadithModel(id: $id, name: $name, hadith_num: $hadith_num)';

  @override
  bool operator ==(covariant HadithModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.hadith_num == hadith_num;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ hadith_num.hashCode;
}

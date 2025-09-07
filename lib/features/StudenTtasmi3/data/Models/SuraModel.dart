// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SuraModel {
  num id;
  String name;
  num ayat_counts;
  SuraModel({
    required this.id,
    required this.name,
    required this.ayat_counts,
  });

  SuraModel copyWith({
    num? id,
    String? name,
    num? ayat_counts,
  }) {
    return SuraModel(
      id: id ?? this.id,
      name: name ?? this.name,
      ayat_counts: ayat_counts ?? this.ayat_counts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'ayat_counts': ayat_counts,
    };
  }
factory SuraModel.fromMap(Map<String, dynamic> map) {
  print( "map is $map");
  return SuraModel(
    id: map['id'] ?? 0,
    name: map['name']?.toString() ?? '',
    ayat_counts: map['ayat_counts'] ?? 0,
  );
}



  String toJson() => json.encode(toMap());

  factory SuraModel.fromJson(String source) => SuraModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Suramodel(id: $id, name: $name, ayat_counts: $ayat_counts)';

  @override
  bool operator ==(covariant SuraModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.ayat_counts == ayat_counts;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ ayat_counts.hashCode;
}

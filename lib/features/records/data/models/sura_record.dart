// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SuraRecord {
   String name;
  SuraRecord({
    required this.name,
  });

  SuraRecord copyWith({
    String? name,
  }) {
    return SuraRecord(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory SuraRecord.fromMap(Map<String, dynamic> map) {
    return SuraRecord(
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SuraRecord.fromJson(String source) => SuraRecord.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SuraRecord(name: $name)';

  @override
  bool operator ==(covariant SuraRecord other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

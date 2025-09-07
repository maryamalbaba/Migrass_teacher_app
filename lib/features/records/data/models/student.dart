// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Studentaudio {
  String first_name;
  String last_name;
  Studentaudio({
    required this.first_name,
    required this.last_name,
  });

  Studentaudio copyWith({
    String? first_name,
    String? last_name,
  }) {
    return Studentaudio(
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_name': first_name,
      'last_name': last_name,
    };
  }

  factory Studentaudio.fromMap(Map<String, dynamic> map) {
    return Studentaudio(
      first_name: map['first_name'] as String,
      last_name: map['last_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Studentaudio.fromJson(String source) => Studentaudio.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Studentaudio(first_name: $first_name, last_name: $last_name)';

  @override
  bool operator ==(covariant Studentaudio other) {
    if (identical(this, other)) return true;
  
    return 
      other.first_name == first_name &&
      other.last_name == last_name;
  }

  @override
  int get hashCode => first_name.hashCode ^ last_name.hashCode;
}

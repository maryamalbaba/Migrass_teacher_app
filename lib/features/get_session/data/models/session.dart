// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Session {
  num? id;
  num? circle_id;
  String date;
  String day;
  String? description;
  Session({
    this.id,
    this.circle_id,
    required this.date,
     required this.day,
    this.description,
  });

  Session copyWith({
    num? id,
    num? circle_id,
    String? date,
    String? day,
    String? description,
  }) {
    return Session(
      id: id ?? this.id,
      circle_id: circle_id ?? this.circle_id,
      date: date ?? this.date,
      day: day ??this.day,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'circle_id': circle_id,
      'date': date,
      'day':day,
      'description':description,
    };
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      id: map['id'] != null ? map['id'] as num : null,
      circle_id: map['circle_id'] != null ? map['circle_id'] as num : null,
      date: map['date'] as String,
      day:map['day'] as String, 
      description: map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Session.fromJson(String source) => Session.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Session(id: $id, circle_id: $circle_id, date: $date, description: $description, day:$day)';
  }

  @override
  bool operator ==(covariant Session other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.circle_id == circle_id &&
      other.date == date &&
      other.day==day&&
      other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      circle_id.hashCode ^
      date.hashCode ^
      description.hashCode;
  }
}

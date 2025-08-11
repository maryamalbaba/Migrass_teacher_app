// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CircleSession {
 num id;
num circle_type_id;
  CircleSession({
    required this.id,
    required this.circle_type_id,
  });
       

  CircleSession copyWith({
    num? id,
    num? circle_type_id,
  }) {
    return CircleSession(
      id: id ?? this.id,
      circle_type_id: circle_type_id ?? this.circle_type_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'circle_type_id': circle_type_id,
    };
  }

  factory CircleSession.fromMap(Map<String, dynamic> map) {
    return CircleSession(
      id: map['id'] as num,
      circle_type_id: map['circle_type_id'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory CircleSession.fromJson(String source) => CircleSession.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CircleSession(id: $id, circle_type_id: $circle_type_id)';

  @override
  bool operator ==(covariant CircleSession other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.circle_type_id == circle_type_id;
  }

  @override
  int get hashCode => id.hashCode ^ circle_type_id.hashCode;
       }

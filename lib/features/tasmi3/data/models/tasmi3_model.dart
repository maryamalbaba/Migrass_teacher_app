// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:teacher/features/tasmi3/data/models/circle_model.dart';

class Tasmi3Model {
 String type;
   List<CircleModel> circles;
  Tasmi3Model({
    required this.type,
    required this.circles,
  });

  Tasmi3Model copyWith({
    String? type,
    List<CircleModel>? circles,
  }) {
    return Tasmi3Model(
      type: type ?? this.type,
      circles: circles ?? this.circles,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'circles': circles.map((x) => x.toMap()).toList(),
    };
  }

factory Tasmi3Model.fromMap(Map<String, dynamic> map) {
  return Tasmi3Model(
    type: map['type']?.toString() ?? '',
    circles: (map['circles'] is List)
        ? List<CircleModel>.from(
            (map['circles'] as List).map(
              (e) => CircleModel.fromMap(e ?? {}),
            ),
          )
        : [],
  );
}


  String toJson() => json.encode(toMap());

  factory Tasmi3Model.fromJson(String source) => Tasmi3Model.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Tasmi3Model(type: $type, circles: $circles)';

  @override
  bool operator ==(covariant Tasmi3Model other) {
    if (identical(this, other)) return true;
  
    return 
      other.type == type &&
      listEquals(other.circles, circles);
  }

  @override
  int get hashCode => type.hashCode ^ circles.hashCode;
}

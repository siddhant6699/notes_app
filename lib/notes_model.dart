import 'package:flutter/cupertino.dart';

final String tableNotes = 'notes';

class NoteFeilds {
  static final List<String> values = [
    id,
    title,
    description,
    createdOn,
    cardColor,
  ];
  static final String id = '_id';
  static final String title = 'title';
  static final String description = 'description';
  static final String createdOn = 'createdon';
  static final String cardColor = 'cardColor';
}

class Note {
  final int? id;
  final String title;
  final String description;
  final DateTime createdOn;
  final String cardColor;

  Note({
    this.id,
    required this.title,
    required this.description,
    required this.createdOn,
    required this.cardColor,
  });

  Note copy({
    int? id,
    String? title,
    String? description,
    DateTime? createdOn,
    String? cardColor,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdOn: createdOn ?? this.createdOn,
        cardColor: cardColor ?? this.cardColor,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFeilds.id] as int,
        title: json[NoteFeilds.title] as String,
        description: json[NoteFeilds.description] as String,
        createdOn: DateTime.parse(json[NoteFeilds.createdOn] as String),
        cardColor: json[NoteFeilds.cardColor] as String,
      );

  Map<String, Object?> toJson() => {
        NoteFeilds.id: id,
        NoteFeilds.title: title,
        NoteFeilds.description: description,
        NoteFeilds.createdOn: createdOn.toIso8601String(),
        NoteFeilds.cardColor: cardColor,
      };
}

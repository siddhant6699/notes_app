final String tableNotes = 'notes';

class NoteFeilds {
  static final List<String> values = [id, title, description, createdOn];
  static final String id = '_id';
  static final String title = 'title';
  static final String description = 'description';
  static final String createdOn = 'createdon';
}

class Note {
  final int? id;
  final String title;
  final String description;
  final DateTime createdOn;

  Note({
    this.id,
    required this.title,
    required this.description,
    required this.createdOn,
  });

  Note copy({
    int? id,
    String? title,
    String? description,
    DateTime? createdOn,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdOn: createdOn ?? this.createdOn,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFeilds.id] as int,
        title: json[NoteFeilds.title] as String,
        description: json[NoteFeilds.description] as String,
        createdOn: DateTime.parse(json[NoteFeilds.createdOn] as String),
      );

  Map<String, Object?> toJson() => {
        NoteFeilds.id: id,
        NoteFeilds.title: title,
        NoteFeilds.description: description,
        NoteFeilds.createdOn: createdOn.toIso8601String(),
      };
}

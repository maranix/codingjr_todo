import 'package:equatable/equatable.dart';

final class Todo extends Equatable {
  const Todo({
    required this.id,
    required this.title,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.completedAt,
    required this.isDone,
  });

  final String id;
  final String title;
  final String note;
  final bool isDone;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime completedAt;

  static Todo get empty {
    final dateTime = DateTime.now();

    return Todo(
      id: '',
      title: '',
      note: '',
      createdAt: dateTime,
      updatedAt: dateTime,
      completedAt: dateTime,
      isDone: false,
    );
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    switch (json) {
      case {
          'id': String id,
          'title': String title,
          'note': String note,
          'is_done': int isDone,
          'created_at': String createdAt,
          'updated_at': String updatedAt,
          'completed_at': String completedAt
        }:
        return Todo(
          id: id,
          title: title,
          note: note,
          isDone: isDone == 1 ? true : false,
          createdAt: DateTime.parse(createdAt),
          updatedAt: DateTime.parse(updatedAt),
          completedAt: DateTime.parse(completedAt),
        );
      default:
        throw FormatException(
          'Could not serialize Todo: malformed json data',
          json,
        );
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'note': note,
        'is_done': isDone == true ? 1 : 0,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'completed_at': completedAt.toIso8601String(),
      };

  Todo copyWith({
    String? id,
    String? title,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
    bool? isDone,
  }) =>
      Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        note: note ?? this.note,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        completedAt: completedAt ?? this.completedAt,
        isDone: isDone ?? this.isDone,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        note,
        isDone,
        createdAt,
        updatedAt,
        completedAt,
      ];
}

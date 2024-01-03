// Importing necessary packages and libraries
import 'package:equatable/equatable.dart';

// Class representing a Todo with Equatable support for equality comparisons
final class Todo extends Equatable {
  // Constructor for creating a Todo instance with required fields
  const Todo({
    required this.id,
    required this.title,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.completedAt,
    required this.isDone,
  });

  // Fields representing properties of a Todo
  final String id;
  final String title;
  final String note;
  final bool isDone;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime completedAt;

  // Factory method to create an empty Todo with current timestamp
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

  // Factory method to create a Todo from JSON data
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

  // Method to convert Todo to JSON format
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'note': note,
        'is_done': isDone == true ? 1 : 0,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'completed_at': completedAt.toIso8601String(),
      };

  // Method to create a copy of the Todo with specified fields updated
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

  // Method required for Equatable to perform equality comparisons
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

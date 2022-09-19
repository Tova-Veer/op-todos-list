// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:todos_api/todos_api.dart';
import 'package:uuid/uuid.dart';

part 'todo.g.dart';

@JsonSerializable()
@immutable
class Todo extends Equatable {
  Todo({
    String? id,
    required this.title,
    this.details = '',
    this.completed = false,
  }) : id = id ?? const Uuid().v4();

  final String id;

  final String title;

  final String details;

  final bool completed;

  Todo copyWith({
    String? id,
    String? title,
    String? details,
    bool? completed,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      details: details ?? this.details,
      completed: completed ?? this.completed,
    );
  }

  static Todo fromJson(JsonMap json) => _$TodoFromJson(json);

  JsonMap toJson() => _$TodoToJson(this);

  @override
  List<Object?> get props => [id, title, details, completed];
}

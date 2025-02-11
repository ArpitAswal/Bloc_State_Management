part of '../bloc/todo_bloc.dart';

class TodoEvent {}
// Base class for all todo events.

class TodoAdded extends TodoEvent {
  // Represents the event of adding a new todo.
  final String todo;

  TodoAdded(this.todo);
}

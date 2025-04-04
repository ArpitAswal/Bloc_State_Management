import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/todo_state.dart';

part '../events/todo_event.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  // Defines the TodoBloc, which extends the Bloc class.
  // It manages a stream of TodoEvent events and emits a stream of TodoState states.
  TodoBloc() : super(TodoInitial()) {
    // Constructor of the TodoBloc.
    // Initializes the initial state of the Bloc to TodoInitial.
    on<TodoAdded>((event, emit) {
      // Defines how to handle TodoAdded events.
      emit(TodoState(todos: [...state.todos, event.todo]));
      // Creates a new TodoState with the updated list of todos.
      // [...state.todos, event.todo] creates a new list by spreading the existing todos and adding the new event.todo to the end.
      // Emits the new TodoState to notify listeners (widgets) that the state has changed.
    });
  }
}

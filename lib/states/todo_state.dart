class TodoInitial extends TodoState {
  // Defines the initial state of the TodoBloc.
  TodoInitial() : super(todos: []);
}

class TodoState {
  // Represents the current state of the todo list.
  final List<String> todos;

  TodoState({required this.todos});

  TodoState copyWith({List<String>? todos}) {
    // Creates a new TodoState with optional modifications.
    // Allows you to create a new state with updated values while keeping
    // the original state immutable.
    return TodoState(todos: todos ?? this.todos);
  }
}
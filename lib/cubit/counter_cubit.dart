import 'package:flutter_bloc/flutter_bloc.dart';

/*
. Cubit is a simplified version of the Bloc library. It's designed for simpler state management scenarios where you don't need the full power of streams.
. It allows you to easily manage and update the state of your application within a specific scope.
. Cubit extends the Cubit<T> class, where T represents the type of your state.

Key Features of Cubit:

1. Simplicity: Easier to learn and use compared to the full Bloc library.
2. State Management: Handles the state of your application efficiently.
3. Reactivity: Automatically rebuilds widgets when the state changes.
4. Testing: Easily testable, making it easier to ensure the correctness of your state management logic.
*/
class CounterCubit extends Cubit<int> {
  //Cubit<int>, indicating that the state will be an integer.
  CounterCubit()
      : super(
            0); // constructor initializes the initial state of the counter to 0.

  void increment() {
    // Increments the current state by 1
    emit(state +
        1); // emit() notifies the listeners (widgets) that the state has changed.
  }

  void decrement() {
    // Decrements the current state by 1
    if (state == 0) {
      // Prevents decrementing below 0.
      return;
    }
    emit(state - 1);
  }
}

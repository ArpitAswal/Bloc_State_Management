import 'package:flutter_bloc/flutter_bloc.dart';

part '../events/counter_event.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  // CounterBloc handles events of type CounterEvent and emits states of type int.
  CounterBloc() : super(0) {
    // Initialize the initial state of the counter to 0
    on<CounterIncremented>((event, emit) {
      // Listen for CounterIncremented events
      emit(state + 1); // Increment the state and emit the new state
    });

    on<CounterDecremented>((event, emit) {
      if (state == 0) return;
      emit(state - 1);
    });
    // This method defines how to handle CounterDecremented events. If the current state is 0, it does nothing. Otherwise, the state is decremented by 1, and the new state is emitted.
  }
}

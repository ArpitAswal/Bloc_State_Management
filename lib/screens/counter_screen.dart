import 'package:bloc_state_management/bloc/counter_bloc.dart';
import 'package:bloc_state_management/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterExample extends StatelessWidget {
  const CounterExample({super.key});

  @override
  Widget build(BuildContext context) {
    // this retrieves an instance of the CounterCubit from the context. This ensures that the CounterCubit is shared among all descendants of the BlocProvider.
    final counterCubit = BlocProvider.of<CounterCubit>(context);
    // this retrieves an instance of the CounterBloc.
    final counterBloc = CounterBloc();

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              //BlocBuilder is used to rebuild the widget whenever the state emitted by the CounterCubit changes.
              BlocBuilder<CounterCubit, int>(
                  // bloc: counterCubit, // If the bloc parameter is omitted, BlocBuilder will automatically perform a lookup using BlocProvider and the current BuildContext.
                  builder: (context, counter) {
                //counter is the current state and builds the UI accordingly
                return Text("Counter value: $counter");
              }),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: counterCubit.increment,
                  child: const Text("Increment")),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: context.read<CounterCubit>().decrement,
                  child: const Text("Decrement")),

              const SizedBox(height: 20),

              // This widget listens for state changes emitted by the counterBloc.
              BlocBuilder<CounterBloc, int>(
                  bloc: counterBloc,
                  // Only specify the bloc if you wish to provide a bloc that will be scoped to a single widget and isn't accessible via a parent BlocProvider and the current BuildContext.
                  builder: (context, counter) {
                    //counter is the current state and builds the UI accordingly
                    return Text("Counter value: $counter");
                  }),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () => counterBloc.add(
                      CounterIncremented()), // Dispatch the CounterIncremented event to the bloc
                  child: const Text("Increment")),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () => counterBloc.add(
                      CounterDecremented()), // Dispatch the CounterDecremented event to the bloc
                  child: const Text("Decrement"))
            ],
          ),
        ));
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    debugPrint('Event: ${bloc.runtimeType} - $event');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugPrint('Transition: ${bloc.runtimeType} - $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('Error: ${bloc.runtimeType} - $error, $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onCreate(BlocBase bloc) {
    debugPrint('Create: ${bloc.runtimeType}');
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
    debugPrint('Close: ${bloc.runtimeType}');
    super.onClose(bloc);
  }
}

/*
What is a BlocObserver?

A BlocObserver is a class that you can extend to define custom behavior for handling BLoC lifecycle events.
It provides methods that are called whenever a specific event occurs in any of your Blocs.
These methods include:

. onCreate(BlocBase bloc): Called when a new Bloc is created.
. onEvent(Bloc bloc, Object? event): Called when an event is added to a Bloc.
. onTransition(Bloc bloc, Transition transition): Called when a Bloc transitions from one state to another.
. onError(BlocBase bloc, Object error, StackTrace stackTrace): Called when an error occurs within a Bloc.
. onClose(BlocBase bloc): Called when a Bloc is closed.

When should we use a BlocObserver?

You should consider using a BlocObserver when:

* You need to debug complex BLoC interactions.
* You want to implement centralized error handling.
* You need to monitor the performance of your BLoC logic.
* You want to track user interactions or other events.
* You need to verify BLoC behavior in unit tests.
 */

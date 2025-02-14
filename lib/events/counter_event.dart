part of '../blocs/counter_bloc.dart';

sealed class CounterEvent {} // Base class for all counter events

final class CounterIncremented
    extends CounterEvent {} // Event for incrementing the counter

final class CounterDecremented
    extends CounterEvent {} // Event for decrementing the counter


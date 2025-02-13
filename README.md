# Title: Bloc_State_Management

#### Lets take a look at how to use BlocProvider to provide a CounterCubit to a CounterPage and react to state changes with BlocBuilder.

- The counter example is available on this repository explore the code and understand it by reading the comment lines.
- In this example you will understand how you can successfully separated the presentational layer from the business logic layer. Notice that the CounterExample widget knows nothing about what happens when a user taps the buttons. The widget simply notifies the CounterCubit that the user has pressed either the increment or decrement button.

## BlocBuilder 

- BlocBuilder is a Flutter widget which requires a bloc and a builder function. BlocBuilder handles building the widget in response to new states. BlocBuilder is very similar to StreamBuilder but has a more simple API to reduce the amount of boilerplate code needed. The builder function will potentially be called many times and should be a pure function that returns a widget in response to the state.
- If the bloc parameter is omitted, BlocBuilder will automatically perform a lookup using BlocProvider and the current BuildContext.

  BlocBuilder<BlocA, BlocAState>(
  builder: (context, state) {
  // return widget here based on BlocA's state
  })

- Only specify the bloc if you wish to provide a bloc that will be scoped to a single widget and isn't accessible via a parent BlocProvider and the current BuildContext.
  
  BlocBuilder<BlocA, BlocAState>(
  bloc: blocA, // provide the local bloc instance
  builder: (context, state) {
  // return widget here based on BlocA's state
  })

- For fine-grained control over when the builder function is called an optional buildWhen can be provided. buildWhen takes the previous bloc state and current bloc state and returns a boolean. If buildWhen returns true, builder will be called with state and the widget will rebuild. If buildWhen returns false, builder will not be called with state and no rebuild will occur.

  BlocBuilder<BlocA, BlocAState>(
  buildWhen: (previousState, state) {
  // return true/false to determine whether or not to rebuild the widget with state
  },
  builder: (context, state) {
  // return widget here based on BlocA's state
  })

## Bloc Selector

- BlocSelector is a Flutter widget which is analogous to BlocBuilder but allows developers to filter updates by selecting a new value based on the current bloc state. Unnecessary builds are prevented if the selected value does not change. The selected value must be immutable in order for BlocSelector to accurately determine whether builder should be called again.
- If the bloc parameter is omitted, BlocSelector will automatically perform a lookup using BlocProvider and the current BuildContext.

  BlocSelector<BlocA, BlocAState, SelectedState>(
  selector: (state) {
  // return selected state based on the provided state.
  },
  builder: (context, state) {
  // return widget here based on the selected state.
  })

## Bloc Provider

- BlocProvider is a Flutter widget which provides a bloc to its children via BlocProvider.of<T>(context). It is used as a dependency injection (DI) widget so that a single instance of a bloc can be provided to multiple widgets within a subtree.
- In most cases, BlocProvider should be used to create new blocs which will be made available to the rest of the subtree. In this case, since BlocProvider is responsible for creating the bloc, it will automatically handle closing it.

  BlocProvider(
  create: (BuildContext context) => BlocA(),
  child: ChildA(),
  );

- By default, BlocProvider will create the bloc lazily, meaning create will get executed when the bloc is looked up via BlocProvider.of<BlocA>(context).
- To override this behavior and force create to be run immediately, lazy can be set to false.

  BlocProvider(
  lazy: false,
  create: (BuildContext context) => BlocA(),
  child: ChildA(),
  );

## MultiBlocProvider

- MultiBlocProvider is a Flutter widget that merges multiple BlocProvider widgets into one. MultiBlocProvider improves the readability and eliminates the need to nest multiple BlocProviders.

  MultiBlocProvider(
  providers: [
  BlocProvider<BlocA>(
  create: (BuildContext context) => BlocA(),),
  BlocProvider<BlocB>(
  create: (BuildContext context) => BlocB(),
  ),
  BlocProvider<BlocC>(
  create: (BuildContext context) => BlocC(),),
  ],
  child: ChildA(),
  )

## BlocListener

- BlocListener is a Flutter widget which takes a BlocWidgetListener and an optional bloc and invokes the listener in response to state changes in the bloc. It should be used for functionality that needs to occur once per state change such as navigation, showing a SnackBar, showing a Dialog, etc...
- listener is only called once for each state change (NOT including the initial state) unlike builder in BlocBuilder and is a void function.

  BlocListener<BlocA, BlocAState>(
  listener: (context, state) {
  // do stuff here based on BlocA's state
  },
  child: Container(),
  )

- For fine-grained control over when the listener function is called an optional listenWhen can be provided. listenWhen takes the previous bloc state and current bloc state and returns a boolean. If listenWhen returns true, listener will be called with state. If listenWhen returns false, listener will not be called with state.

  BlocListener<BlocA, BlocAState>(
  listenWhen: (previousState, state) {
  // return true/false to determine whether or not to call listener with state
  },
  listener: (context, state) {
  // do stuff here based on BlocA's state
  },
  child: Container(),
  )

## MultiBlocListener

- MultiBlocListener is a Flutter widget that merges multiple BlocListener widgets into one. MultiBlocListener improves the readability and eliminates the need to nest multiple BlocListeners.

  MultiBlocListener(
  listeners: [
  BlocListener<BlocA, BlocAState>(
  listener: (context, state) {},
  ),
  BlocListener<BlocB, BlocBState>(
  listener: (context, state) {},
  ),
  BlocListener<BlocC, BlocCState>(
  listener: (context, state) {},
  ),
  ],
  child: ChildA(),
  )

## BlocConsumer

- BlocConsumer exposes a builder and listener in order react to new states. BlocConsumer is analogous to a nested BlocListener and BlocBuilder but reduces the amount of boilerplate needed. BlocConsumer should only be used when it is necessary to both rebuild UI and execute other reactions to state changes in the bloc. BlocConsumer takes a required BlocWidgetBuilder and BlocWidgetListener and an optional bloc, BlocBuilderCondition, and BlocListenerCondition.
- If the bloc parameter is omitted, BlocConsumer will automatically perform a lookup using BlocProvider and the current BuildContext.

  BlocConsumer<BlocA, BlocAState>(
  listener: (context, state) {
  // do stuff here based on BlocA's state
  },
  builder: (context, state) {
  // return widget here based on BlocA's state
  }
  )

- An optional listenWhen and buildWhen can be implemented for more granular control over when listener and builder are called. The listenWhen and buildWhen will be invoked on each bloc state change. They each take the previous state and current state and must return a bool which determines whether or not the builder and/or listener function will be invoked. The previous state will be initialized to the state of the bloc when the BlocConsumer is initialized. listenWhen and buildWhen are optional and if they aren't implemented, they will default to true.

  BlocConsumer<BlocA, BlocAState>(
  listenWhen: (previous, current) {
  // return true/false to determine whether or not
  // to invoke listener with state
  },
  listener: (context, state) {
  // do stuff here based on BlocA's state
  },
  buildWhen: (previous, current) {
  // return true/false to determine whether or not
  // to rebuild the widget with state
  },
  builder: (context, state) {
  // return widget here based on BlocA's state
  }
  )

## RepositoryProvider

- RepositoryProvider is a Flutter widget which provides a repository to its children via RepositoryProvider.of<T>(context). It is used as a dependency injection (DI) widget so that a single instance of a repository can be provided to multiple widgets within a subtree. BlocProvider should be used to provide blocs whereas RepositoryProvider should only be used for repositories.

  RepositoryProvider(
  create: (context) => RepositoryA(),
  child: ChildA(),
  );

- then from ChildA we can retrieve the Repository instance with:

  // with extensions
  context.read<RepositoryA>();

  // without extensions
  RepositoryProvider.of<RepositoryA>(context)

## MultiRepositoryProvider

- MultiRepositoryProvider is a Flutter widget that merges multiple RepositoryProvider widgets into one. MultiRepositoryProvider improves the readability and eliminates the need to nest multiple RepositoryProvider.

  MultiRepositoryProvider(
  providers: [
  RepositoryProvider<RepositoryA>(
  create: (context) => RepositoryA(),
  ),
  RepositoryProvider<RepositoryB>(
  create: (context) => RepositoryB(),
  ),
  RepositoryProvider<RepositoryC>(
  create: (context) => RepositoryC(),
  ),
  ],
  child: ChildA(),
  )


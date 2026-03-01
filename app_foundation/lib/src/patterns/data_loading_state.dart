/// Generic data loading state machine.
///
/// Manages the lifecycle: initial → loading → loaded/error/empty.
/// Every screen should use this to handle async data consistently.
///
/// ```dart
/// // In your state management:
/// DataLoadingState<List<Transaction>> state = DataLoadingState.initial();
///
/// // When loading:
/// state = DataLoadingState.loading();
///
/// // On success:
/// state = DataLoadingState.loaded(transactions);
///
/// // On empty:
/// state = DataLoadingState.empty();
///
/// // On error:
/// state = DataLoadingState.error('Failed to load transactions');
///
/// // In your widget:
/// state.when(
///   initial: () => SizedBox.shrink(),
///   loading: () => FinSkeleton(...),
///   loaded: (data) => TransactionList(data),
///   empty: () => FinEmptyPage(...),
///   error: (message) => FinErrorView(message),
/// );
/// ```
sealed class DataLoadingState<T> {
  const DataLoadingState._();

  /// Initial state before any load.
  const factory DataLoadingState.initial() = DataLoadingInitial<T>;

  /// Loading in progress.
  const factory DataLoadingState.loading() = DataLoadingLoading<T>;

  /// Data loaded successfully.
  const factory DataLoadingState.loaded(T data) = DataLoadingLoaded<T>;

  /// No data available.
  const factory DataLoadingState.empty() = DataLoadingEmpty<T>;

  /// Error occurred.
  const factory DataLoadingState.error(String message) = DataLoadingError<T>;

  /// Pattern-matching helper.
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T data) loaded,
    required R Function() empty,
    required R Function(String message) error,
  }) {
    final self = this;
    if (self is DataLoadingInitial<T>) return initial();
    if (self is DataLoadingLoading<T>) return loading();
    if (self is DataLoadingLoaded<T>) return loaded(self.data);
    if (self is DataLoadingEmpty<T>) return empty();
    if (self is DataLoadingError<T>) return error(self.message);
    throw StateError('Unknown state: $self');
  }

  /// Whether data is currently loading.
  bool get isLoading => this is DataLoadingLoading<T>;

  /// Whether data has been loaded.
  bool get isLoaded => this is DataLoadingLoaded<T>;

  /// Whether an error occurred.
  bool get isError => this is DataLoadingError<T>;
}

class DataLoadingInitial<T> extends DataLoadingState<T> {
  const DataLoadingInitial() : super._();
}

class DataLoadingLoading<T> extends DataLoadingState<T> {
  const DataLoadingLoading() : super._();
}

class DataLoadingLoaded<T> extends DataLoadingState<T> {
  const DataLoadingLoaded(this.data) : super._();
  final T data;
}

class DataLoadingEmpty<T> extends DataLoadingState<T> {
  const DataLoadingEmpty() : super._();
}

class DataLoadingError<T> extends DataLoadingState<T> {
  const DataLoadingError(this.message) : super._();
  final String message;
}

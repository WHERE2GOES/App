sealed class Result<T> {
  // empty
}

final class Success<T> extends Result<T> {
  final T data;
  Success({required this.data});
}

final class Failure<T> extends Result<T> {
  final Exception exception;
  Failure({required this.exception});
}
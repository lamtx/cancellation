base class CancellationException implements Exception {
  const CancellationException();

  @override
  String toString() => "Operation was cancelled.";
}

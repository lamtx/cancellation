abstract interface class Cancellable {
  factory Cancellable(void Function() callback) = _CancellableCallback;

  void cancel();
}

final class _CancellableCallback implements Cancellable {
  _CancellableCallback(this._callback);

  final void Function() _callback;

  @override
  void cancel() => _callback();
}

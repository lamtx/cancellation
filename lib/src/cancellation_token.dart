import 'cancellation_exception.dart';

abstract interface class CancellationToken {
  bool get isCancelled;

  void addOnCancel(void Function() callback);

  static const CancellationToken neverCancel = _NeverCancelToken();
}

final class _NeverCancelToken implements CancellationToken {
  const _NeverCancelToken();

  @override
  bool get isCancelled => false;

  @override
  void addOnCancel(void Function() callback) {}
}

extension CancellationTokenExt on CancellationToken {
  void throwIfCancelled() {
    if (isCancelled) {
      throw const CancellationException();
    }
  }
}

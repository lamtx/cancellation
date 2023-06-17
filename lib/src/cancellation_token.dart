import 'cancellation_exception.dart';

abstract interface class CancellationToken {
  bool get isCancelled;

  static const CancellationToken neverCancel = _NeverCancelToken();
}

final class _NeverCancelToken implements CancellationToken {
  const _NeverCancelToken();

  @override
  bool get isCancelled => false;
}

extension CancellationTokenExt on CancellationToken {
  void throwIfCancelled() {
    if (isCancelled) {
      throw const CancellationException();
    }
  }
}

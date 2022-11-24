import 'cancellation_exception.dart';

abstract class CancellationToken {
  bool get isCancelled;

  static const CancellationToken neverCancel = _NeverCancelToken();
}

class _NeverCancelToken implements CancellationToken {
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

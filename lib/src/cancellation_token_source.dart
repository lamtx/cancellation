import 'cancellable.dart';
import 'cancellation_token.dart';

abstract class CancellationTokenSource implements Cancellable {
  factory CancellationTokenSource() = _CancellationTokenSourceImpl;

  void cancel();

  CancellationToken get token;

  CancellationTokenSource create();
}

class _CancellationTokenSourceImpl implements CancellationTokenSource {
  _CancellationTokenSourceImpl([_CancellationTokenImpl? parentToken])
      : _token = _CancellationTokenImpl(false, parentToken);

  final _CancellationTokenImpl _token;

  @override
  void cancel() {
    _token.cancel();
  }

  @override
  CancellationTokenSource create() {
    return _CancellationTokenSourceImpl(_token);
  }

  @override
  CancellationToken get token => _token;
}

typedef _VoidCallBack = void Function();

class _CancellationTokenImpl implements CancellationToken {
  _CancellationTokenImpl([this._isCancelled = false, this._parent]);

  bool _isCancelled;
  final CancellationToken? _parent;

  List<_VoidCallBack> _callbacks = [];

  @override
  bool get isCancelled =>
      _isCancelled || (_parent != null && _parent!.isCancelled);

  void cancel() {
    _isCancelled = true;
    final list = _callbacks;
    _callbacks = [];
    for (final callback in list) {
      callback();
    }
  }

  @override
  void addOnCancel(void Function() callback) {
    if (isCancelled) {
      callback();
    } else {
      _callbacks.add(callback);
    }
  }
}

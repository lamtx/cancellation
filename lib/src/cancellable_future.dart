import 'cancellation_token.dart';

extension CancellableFuture<T> on Future<T> {
  Future<T> asCancellable(CancellationToken cancellationToken) async {
    final value = await this;
    cancellationToken.throwIfCancelled();
    return value;
  }
}

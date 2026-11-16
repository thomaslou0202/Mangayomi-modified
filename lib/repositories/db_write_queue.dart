import 'dart:async';

class DbWriteQueue {
  Future<void> _tail = Future.value();
  int _pending = 0;

  // Chains every write onto the same Future tail so none overlap in Isar's transaction lock.
  Future<T> run<T>(FutureOr<T> Function() body) {
    _pending++;
    final result = _tail.then((_) => body());
    _tail = result.then((_) {}, onError: (_) {});
    _tail.whenComplete(() => _pending--);
    return result;
  }

  /// Completes once every write queued so far has finished.
  Future<void> whenIdle() => _tail;

  /// Whether no write is queued or running. Lets a widget test, whose clock
  /// does not move Isar's background transactions along, pump until they land.
  bool get isIdle => _pending == 0;
}

// Only serializes the main isolate; isolate_service.dart's worker isar instance isn't covered.
final dbWriteQueue = DbWriteQueue();

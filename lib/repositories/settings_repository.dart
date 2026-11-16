import 'dart:async';

import 'package:isar_community/isar.dart';
import 'package:mangayomi/repositories/db.dart';
import 'package:mangayomi/models/settings.dart';
import 'package:mangayomi/repositories/db_write_queue.dart';
import 'package:mangayomi/utils/error_toast.dart';

class SettingsRepository {
  Settings get current => isar.settings.getSync(227)!;

  Settings? get currentOrNull {
    try {
      return isar.settings.getSync(227);
    } catch (error, stackTrace) {
      recordError(error, stack: stackTrace, source: 'settings_repository');
      return null;
    }
  }

  Future<Settings?> get currentAsync => isar.settings.get(227);

  List<Settings> getAll() => isar.settings.filter().idIsNotNull().findAllSync();

  Stream<Settings> watch() => isar.settings
      .where()
      .idEqualTo(227)
      .watch(fireImmediately: true)
      .map((l) => l.first);

  // These writes are asynchronous transactions. The Settings row carries
  // per-title lists, so it grows with the library, and a synchronous commit
  // held the UI thread for its whole write and flush - and, while a sync was
  // writing in the background, for as long as that held the database lock.
  // Opening a title paid that every time.
  Future<void> update(void Function(Settings s) mutate) => dbWriteQueue.run(
    () => isar.writeTxn(() async {
      // A damaged/partially-created database must not turn every settings
      // control into a null-check crash. Recreate the singleton row with its
      // model defaults and apply the requested change in the same transaction.
      final s = await _readForWrite() ?? Settings();
      mutate(s);
      s.updatedAt = DateTime.now().millisecondsSinceEpoch;
      await isar.settings.put(s);
    }),
  );

  Future<Settings?> _readForWrite() async {
    try {
      return await isar.settings.get(227);
    } catch (error, stackTrace) {
      recordError(error, stack: stackTrace, source: 'settings_repository');
      return null;
    }
  }

  // Like update(), but leaves updatedAt alone: for app state this device keeps
  // (when Updates was last seen), which is not a settings change and must not
  // make this device's settings win the next sync.
  Future<void> updateLocalState(void Function(Settings s) mutate) =>
      dbWriteQueue.run(
        () => isar.writeTxn(() async {
          final s = await _readForWrite() ?? Settings();
          mutate(s);
          await isar.settings.put(s);
        }),
      );

  // For callers that already hold the Settings instance to mutate (e.g. a family
  // provider's cached param) rather than wanting a freshly-fetched one.
  Future<void> save(Settings s) => dbWriteQueue.run(
    () => isar.writeTxn(() async {
      s.updatedAt = DateTime.now().millisecondsSinceEpoch;
      await isar.settings.put(s);
    }),
  );

  // Sync primitive below is for callers already inside a write transaction
  // opened by transaction()/writeTransaction() — it doesn't queue on its own.
  void putSync(Settings s) => isar.settings.putSync(s);

  Future<int> putAsync(Settings s) => isar.settings.put(s);

  void putAllSync(List<Settings> settingsList) =>
      isar.settings.putAllSync(settingsList);

  void clearSync() => isar.settings.clearSync();

  // Escape hatch for Settings-rooted transactions too specific to name
  // (e.g. first-run seeding).
  Future<T> transaction<T>(FutureOr<T> Function() body) =>
      dbWriteQueue.run(body);

  // Same, but opens the write transaction too, so callers never touch isar.
  Future<T> writeTransaction<T>(T Function() body) =>
      dbWriteQueue.run(() => isar.writeTxnSync(body));

  Future<T> writeTransactionAsync<T>(Future<T> Function() body) =>
      dbWriteQueue.run(() => isar.writeTxn(body));
}

final settingsRepository = SettingsRepository();

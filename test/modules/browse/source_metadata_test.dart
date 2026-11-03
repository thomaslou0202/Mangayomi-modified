import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:shiori/shiori.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar_community/isar.dart';
import 'package:mangayomi/l10n/generated/app_localizations.dart';
import 'package:mangayomi/main.dart' as app;
import 'package:mangayomi/models/manga.dart';
import 'package:mangayomi/models/settings.dart';
import 'package:mangayomi/models/source.dart';
import 'package:mangayomi/modules/browse/sources/sources_screen.dart';
import 'package:mangayomi/modules/browse/sources/widgets/source_list_tile.dart';
import 'package:mangayomi/modules/more/settings/browse/providers/browse_state_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory directory;

  setUpAll(() async {
    final overrides = HttpOverrides.current;
    HttpOverrides.global = null;
    try {
      await Isar.initializeIsarCore(download: true);
    } finally {
      HttpOverrides.global = overrides;
    }
  });
  setUp(() async {
    directory = await Directory.systemTemp.createTemp('source_metadata_');
    app.isar = await Isar.open(
      [SourceSchema, SettingsSchema],
      directory: directory.path,
      name: 'source_${directory.path.hashCode}',
    );
    await app.isar.writeTxn(() => app.isar.settings.put(Settings()));
  });
  tearDown(() async {
    await app.isar.close(deleteFromDisk: true);
    await directory.delete(recursive: true);
  });

  Source legacy(ItemType type) =>
      Source(
          id: 42,
          name: 'Legacy ${type.name}',
          lang: 'zh',
          itemType: type,
          isAdded: true,
        )
        ..lastUsed = null
        ..isPinned = null
        ..isNsfw = null
        ..iconUrl = null;

  Future<void> show(
    WidgetTester tester,
    ItemType type,
    List<Source> sources,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          getSourcesStreamProvider(type)
              .overrideWith((ref) => Stream.value(sources)),
          isExtensionServerInstalledStreamProvider.overrideWith(
            (ref) => Stream.value(true),
          ),
        ],
        child: MaterialApp(
          theme: buildShioriTheme(
            brightness: Brightness.dark,
            colors: FlexColor.schemesList[2].dark,
            tintSurfaces: false,
            blendLevel: 10,
            density: ShioriDensity.phone,
          ),
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SourcesScreen(
              itemType: type,
              tabs: const [],
              tabIndex: (_) {},
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  test('old JSON uses constructor defaults for missing display metadata', () {
    final source = Source.fromJson({'id': 7, 'itemType': 0});
    expect(
      [source.lastUsed, source.isPinned, source.isNsfw, source.isAdded],
      [false, false, false, false],
    );
    expect(source.isActive, true);
    expect([source.name, source.lang, source.iconUrl], ['', '', '']);
  });
  test(
    'explicit nulls are repaired while saved preferences and identity survive',
    () {
      final source = Source.fromJson({
        'id': 8,
        'itemType': 0,
        'name': 'Saved source',
        'isActive': false,
        'isAdded': true,
        'isPinned': true,
        'lastUsed': true,
        'isNsfw': true,
        'lang': null,
        'iconUrl': null,
        'sourceCode': 'existing-code',
      });
      expect(
        [source.id, source.name, source.sourceCode],
        [8, 'Saved source', 'existing-code'],
      );
      expect(
        [
          source.isActive,
          source.isAdded,
          source.isPinned,
          source.lastUsed,
          source.isNsfw,
        ],
        [false, true, true, true, true],
      );
      expect([source.lang, source.iconUrl], ['', '']);
    },
  );

  for (final type in ItemType.values) {
    testWidgets('${type.name} sources render persisted nullable flags', (
      tester,
    ) async {
      final source = (await tester.runAsync(() async {
        await app.isar.writeTxn(() => app.isar.sources.put(legacy(type)));
        return app.isar.sources.getSync(42);
      }))!;
      expect(source.lastUsed, isNull); // Old Isar rows bypass Source.fromJson.
      expect(source.isPinned, isNull);
      await show(tester, type, [source]);
      expect(find.text('Legacy ${type.name}'), findsOneWidget);
      expect(
        find.byType(SourceListTile),
        findsNWidgets(2),
      ); // Includes local files.
      expect(tester.takeException(), isNull);
      // Dispose provider listeners before the temporary database is closed.
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    });
  }
  testWidgets('missing language and name do not break sorting or tiles', (
    tester,
  ) async {
    final source = legacy(ItemType.manga)
      ..lang = null
      ..name = null;
    await show(tester, ItemType.manga, [
      source,
      Source(id: 43, name: 'Normal', lang: 'zh'),
    ]);
    expect(find.text('Unknown'), findsOneWidget);
    expect(find.text('Normal'), findsOneWidget);
    expect(tester.takeException(), isNull);
    // Dispose provider listeners before the temporary database is closed.
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
  testWidgets(
    'pinning a legacy source persists the first pin without an exception',
    (tester) async {
      final source = legacy(ItemType.manga);
      await tester.runAsync(
        () => app.isar.writeTxn(() => app.isar.sources.put(source)),
      );
      await show(tester, ItemType.manga, [source]);
      await tester.tap(
        find.widgetWithIcon(IconButton, Icons.push_pin_outlined),
      );
      await tester.pump();
      expect(app.isar.sources.getSync(42)!.isPinned, true);
      expect(tester.takeException(), isNull);
      // Dispose provider listeners before the temporary database is closed.
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );
  testWidgets(
    'no enabled sources still shows the empty state and local files',
    (tester) async {
      await show(tester, ItemType.manga, []);
      expect(find.text('No sources installed!'), findsOneWidget);
      expect(find.byType(SourceListTile), findsOneWidget);
      expect(tester.takeException(), isNull);
      // Dispose provider listeners before the temporary database is closed.
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );
}

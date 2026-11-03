import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:shiori/shiori.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mangayomi/l10n/generated/app_localizations.dart';
import 'package:mangayomi/models/manga.dart';
import 'package:mangayomi/modules/manga/detail/widgets/detail_explore_sheet.dart';

Manga fixture({ItemType itemType = ItemType.manga}) => Manga(
  name: 'Example title',
  link: 'https://example.com/comic/12/',
  source: 'Example',
  sourceId: 42,
  lang: 'zh',
  author: '',
  artist: '',
  genre: [],
  imageUrl: '',
  status: Status.ongoing,
  description: '',
  itemType: itemType,
);

void main() {
  testWidgets('comic and novel comments open their website in comment mode', (
    tester,
  ) async {
    for (final itemType in [ItemType.manga, ItemType.novel]) {
      Map<String, dynamic>? opened;
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, _) => Scaffold(
              body: DetailExploreButton(manga: fixture(itemType: itemType)),
            ),
          ),
          GoRoute(
            path: '/mangawebview',
            builder: (_, state) {
              opened = state.extra as Map<String, dynamic>;
              return const Scaffold(body: Text('Website'));
            },
          ),
        ],
      );
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: router,
            theme: buildShioriTheme(
              brightness: Brightness.dark,
              colors: FlexColor.schemesList[2].dark,
              tintSurfaces: false,
              blendLevel: 10,
              density: ShioriDensity.phone,
            ),
            locale: const Locale('zh', 'TW'),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Symbols.explore_rounded));
      await tester.pumpAndSettle();
      expect(find.text('推薦'), findsOneWidget);
      expect(find.text('相關作品'), findsOneWidget);
      expect(find.text('評論'), findsOneWidget);
      await tester.tap(find.text('評論'));
      await tester.pumpAndSettle();
      expect(opened?['url'], 'https://example.com/comic/12/');
      expect(opened?['focusComments'], isTrue);
      expect(opened?['title'], contains('評論'));
      await tester.pumpWidget(const SizedBox());
      router.dispose();
    }
  });

  testWidgets(
    'local archive retains discovery without a website comments button',
    (tester) async {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, _) => Scaffold(
              body: DetailExploreButton(
                manga: fixture()..isLocalArchive = true,
              ),
            ),
          ),
        ],
      );
      addTearDown(router.dispose);
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: router,
            theme: buildShioriTheme(
              brightness: Brightness.dark,
              colors: FlexColor.schemesList[2].dark,
              tintSurfaces: false,
              blendLevel: 10,
              density: ShioriDensity.phone,
            ),
            locale: const Locale('zh', 'TW'),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Symbols.explore_rounded));
      await tester.pumpAndSettle();
      expect(find.text('相關作品'), findsOneWidget);
      expect(find.text('評論'), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );
}

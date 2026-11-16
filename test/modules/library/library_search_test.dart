import 'package:flutter_test/flutter_test.dart';
import 'package:mangayomi/models/manga.dart';
import 'package:mangayomi/modules/library/providers/library_filter_provider.dart';

Manga _manga(
  String name, {
  String source = 'src',
  List<String> genre = const [],
}) => Manga(
  name: name,
  source: source,
  genre: genre,
  author: '',
  artist: '',
  description: '',
  link: '/$name',
  status: Status.ongoing,
  imageUrl: '',
  lang: 'zh',
  sourceId: 1,
  favorite: true,
  itemType: ItemType.novel,
);

void main() {
  test('terms are split on commas, trimmed and lower-cased once', () {
    expect(searchKeywords(' Dog , SCISSORS,, '), ['dog', 'scissors']);
    expect(searchKeywords(''), isEmpty);
  });

  test('matches title, source or genre, case-insensitively', () {
    final manga = _manga('狗與剪刀 Dog', source: 'Wenku8', genre: ['Comedy']);

    expect(matchesSearchKeywords(manga, searchKeywords('dog')), isTrue);
    expect(matchesSearchKeywords(manga, searchKeywords('wenku')), isTrue);
    expect(matchesSearchKeywords(manga, searchKeywords('comedy')), isTrue);
    expect(matchesSearchKeywords(manga, searchKeywords('剪刀')), isTrue);
    expect(matchesSearchKeywords(manga, searchKeywords('horror')), isFalse);
  });

  test('any one of several terms is enough', () {
    final manga = _manga('Frieren');
    expect(matchesSearchKeywords(manga, searchKeywords('nope, frier')), isTrue);
  });

  test('a new object for a renamed title is searched by its new name', () {
    expect(matchesSearchKeywords(_manga('Old'), searchKeywords('old')), isTrue);
    expect(
      matchesSearchKeywords(_manga('New'), searchKeywords('old')),
      isFalse,
    );
  });
}

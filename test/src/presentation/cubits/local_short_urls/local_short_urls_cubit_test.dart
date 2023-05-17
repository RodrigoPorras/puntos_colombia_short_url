import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:puntos_colombia_short_url/src/domain/models/short_url.dart';
import 'package:puntos_colombia_short_url/src/presentation/cubits/local_short_urls/local_short_urls_cubit.dart';

import '../../../../mocks/mocks.mocks.dart';

void main() {
  late LocalShortUrlsCubit localShortUrlsCubit;
  late MockDatabaseRepository mockRepository;

  setUp(() {
    mockRepository = MockDatabaseRepository();
    localShortUrlsCubit = LocalShortUrlsCubit(mockRepository);
  });

  tearDown(() {
    localShortUrlsCubit.close();
  });

  group('LocalShortUrlsCubit', () {
    test('initial state is LocalShortUrlsLoading', () {
      expect(localShortUrlsCubit.state, LocalShortUrlsLoading());
    });

    test('emits LocalShortUrlsSuccess when getAllSavedShortUrls is called',
        () async {
      final exampleUrlsHistory = [
        ShortUrl('https://example.com', 'https://short.csd'),
        ShortUrl('https://example2.com', 'https://short2.csd'),
      ];

      when(mockRepository.getUrlsHistory())
          .thenAnswer((_) async => exampleUrlsHistory);

      await localShortUrlsCubit.getAllSavedShortUrls();

      expect(
        localShortUrlsCubit.state,
        LocalShortUrlsSuccess(allUrlsHistory: exampleUrlsHistory),
      );
    });

    test('emits LocalShortUrlsSuccess when saveShortUrl is called', () async {
      final exampleShortUrl =
          ShortUrl('https://example2.com', 'https://short2.csd');

      final exampleUrlsHistory = [
        ShortUrl('https://example.com', 'https://short.csd'),
        exampleShortUrl,
      ];

      when(mockRepository.getUrlsHistory())
          .thenAnswer((_) async => exampleUrlsHistory);

      await localShortUrlsCubit.saveShortUrl(shortUrl: exampleShortUrl);

      expect(
        localShortUrlsCubit.state,
        LocalShortUrlsSuccess(allUrlsHistory: exampleUrlsHistory),
      );
    });
  });
}

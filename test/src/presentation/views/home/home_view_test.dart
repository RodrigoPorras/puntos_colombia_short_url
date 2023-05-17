import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:oktoast/oktoast.dart';
import 'package:puntos_colombia_short_url/config/labels.dart';
import 'package:puntos_colombia_short_url/generated/l10n.dart';
import 'package:puntos_colombia_short_url/src/domain/models/short_url.dart';
import 'package:puntos_colombia_short_url/src/presentation/cubits/clean_uri/clean_uri_cubit.dart';
import 'package:puntos_colombia_short_url/src/presentation/cubits/local_short_urls/local_short_urls_cubit.dart';
import 'package:puntos_colombia_short_url/src/presentation/views/home/home_view.dart';

import '../../../../mocks/mocks.mocks.dart';

void main() {
  late MockCleanUriCubit mockCleanUriCubit;
  late MockLocalShortUrlsCubit mockLocalShortUrlsCubit;

  setUp(() {
    mockCleanUriCubit = MockCleanUriCubit();
    mockLocalShortUrlsCubit = MockLocalShortUrlsCubit();
  });

  tearDown(() {
    mockCleanUriCubit.close();
    mockLocalShortUrlsCubit.close();
  });

  Widget createHomeView() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CleanUriCubit>.value(value: mockCleanUriCubit),
        BlocProvider<LocalShortUrlsCubit>.value(
          value: mockLocalShortUrlsCubit,
        ),
      ],
      child: OKToast(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            S.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: HomeView(),
        ),
      ),
    );
  }

  testWidgets('renders AppBar with correct title', (WidgetTester tester) async {
    await tester.pumpWidget(createHomeView());

    final titleFinder = find.text(labels.home_title);
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('displays CircularProgressIndicator when LocalShortUrlsLoading',
      (WidgetTester tester) async {
    when(mockLocalShortUrlsCubit.state).thenReturn(LocalShortUrlsLoading());

    await tester.pumpWidget(createHomeView());

    final progressIndicatorFinder = find.byType(CircularProgressIndicator);
    expect(progressIndicatorFinder, findsOneWidget);
  });

  testWidgets(
      'displays the saved short URLs when LocalShortUrlsSuccess with non-empty list',
      (WidgetTester tester) async {
    final exampleUrlsHistory = [
      ShortUrl('https://example.com', 'https://short.com'),
      ShortUrl('https://google.com', 'https://goo.gl'),
    ];
    final successState =
        LocalShortUrlsSuccess(allUrlsHistory: exampleUrlsHistory);

    when(mockLocalShortUrlsCubit.state).thenReturn(successState);

    await tester.pumpWidget(createHomeView());

    expect(mockLocalShortUrlsCubit.state, successState);
  });

  testWidgets(
      'does not display any short URLs when LocalShortUrlsSuccess with empty list',
      (WidgetTester tester) async {
    final emptyListState = LocalShortUrlsSuccess(allUrlsHistory: []);
    when(mockLocalShortUrlsCubit.state).thenReturn(emptyListState);

    await tester.pumpWidget(createHomeView());

    final cardFinder = find.byType(Card);
    expect(cardFinder, findsNothing);
  });

  testWidgets('taps on the ElevatedButton and calls shortenUrl',
      (WidgetTester tester) async {
    final inputText = 'https://example.com';
    when(mockCleanUriCubit.state).thenReturn(CleanUriLoading());

    await tester.pumpWidget(createHomeView());

    final inputFieldFinder = find.byType(TextFormField);
    expect(inputFieldFinder, findsOneWidget);

    final buttonFinder = find.byType(ElevatedButton);
    expect(buttonFinder, findsOneWidget);

    await tester.enterText(inputFieldFinder, inputText);
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    verify(mockCleanUriCubit.shortenUrl(url: inputText)).called(1);
  });
}

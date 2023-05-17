import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:puntos_colombia_short_url/src/domain/models/responses/clean_uri_response.dart';
import 'package:puntos_colombia_short_url/src/presentation/cubits/clean_uri/clean_uri_cubit.dart';
import 'package:puntos_colombia_short_url/src/utils/resources/data_state.dart';

import '../../../../mocks/mocks.mocks.dart';

void main() {
  late CleanUriCubit cleanUriCubit;
  late MockCleanUriApiRepository mockRepository;

  setUp(() {
    mockRepository = MockCleanUriApiRepository();
    cleanUriCubit = CleanUriCubit(mockRepository);
  });

  tearDown(() {
    cleanUriCubit.close();
  });

  group('CleanUriCubit', () {
    final exampleUrl = 'https://example.com';

    test('initial state is CleanUriLoading', () {
      expect(cleanUriCubit.state, CleanUriLoading());
    });

    test('emits CleanUriSuccess when API call is successful', () async {
      final exampleResultUrl = 'https://cleaned-url.com';
      final response =
          DataSuccess(CleanUriResponse(resulUrl: exampleResultUrl));

      when(mockRepository.shortenUrl(url: exampleUrl))
          .thenAnswer((_) async => response);

      final expectedStates = [
        CleanUriLoading(),
        CleanUriSuccess(resultUrl: exampleResultUrl),
      ];

      expectLater(cleanUriCubit.stream, emitsInOrder(expectedStates));

      await cleanUriCubit.shortenUrl(url: exampleUrl);
    });

    test('emits CleanUriError when API call fails', () async {
      final errorMessage = 'Error message';
      final response = DataFailed<CleanUriResponse>(
          DioError(requestOptions: RequestOptions(), message: errorMessage));

      when(mockRepository.shortenUrl(url: exampleUrl))
          .thenAnswer((_) async => response);

      final expectedStates = [
        CleanUriLoading(),
        CleanUriError(errorMessage: errorMessage),
      ];

      expectLater(cleanUriCubit.stream, emitsInOrder(expectedStates));

      await cleanUriCubit.shortenUrl(url: exampleUrl);
    });
  });
}

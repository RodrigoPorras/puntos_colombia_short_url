import 'package:puntos_colombia_short_url/src/data/base/base_api_repository.dart';
import 'package:puntos_colombia_short_url/src/data/datasources/remote/clean_uri_api_service.dart';
import 'package:puntos_colombia_short_url/src/domain/models/repositories/clean_uri_api_repository.dart';
import 'package:puntos_colombia_short_url/src/utils/resources/data_state.dart';
import 'package:puntos_colombia_short_url/src/domain/models/responses/clean_uri_response.dart';

class CleanUriApiRepositoryImpl extends BaseApiRepository
    implements CleanUriApiRepository {
  final CleanUriApiService _cleanUriApiService;

  CleanUriApiRepositoryImpl(this._cleanUriApiService);

  @override
  Future<DataState<CleanUriResponse>> shortenUrl({required String url}) {
    return getStateOf(
      request: () => _cleanUriApiService.shortenUrl(
        map: {'url': Uri.encodeFull(url)},
      ),
    );
  }
}

import 'package:puntos_colombia_short_url/src/domain/models/responses/clean_uri_response.dart';
import 'package:puntos_colombia_short_url/src/utils/resources/data_state.dart';

abstract class CleanUriApiRepository {
  Future<DataState<CleanUriResponse>> shortenUrl({required String url});
}

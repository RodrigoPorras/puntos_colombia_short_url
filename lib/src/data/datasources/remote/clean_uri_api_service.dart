import 'package:dio/dio.dart';
import 'package:puntos_colombia_short_url/src/domain/models/responses/clean_uri_response.dart';
import 'package:puntos_colombia_short_url/src/utils/constants/strings.dart';
import 'package:retrofit/retrofit.dart';

part 'clean_uri_api_service.g.dart';

@RestApi(baseUrl: baseUrl, parser: Parser.MapSerializable)
abstract class CleanUriApiService {
  factory CleanUriApiService(Dio dio, {String baseUrl}) = _CleanUriApiService;

  @POST('/shorten')
  Future<HttpResponse<CleanUriResponse>> shortenUrl({@Body() required Map<String, dynamic> map});
}

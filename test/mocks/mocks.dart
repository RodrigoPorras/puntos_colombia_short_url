import 'package:mockito/annotations.dart';
import 'package:puntos_colombia_short_url/src/domain/models/repositories/clean_uri_api_repository.dart';
import 'package:puntos_colombia_short_url/src/domain/models/repositories/database_repository.dart';
import 'package:puntos_colombia_short_url/src/presentation/cubits/clean_uri/clean_uri_cubit.dart';
import 'package:puntos_colombia_short_url/src/presentation/cubits/local_short_urls/local_short_urls_cubit.dart';

@GenerateMocks([
  CleanUriApiRepository,
  DatabaseRepository,
], customMocks: [
  MockSpec<LocalShortUrlsCubit>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<CleanUriCubit>(onMissingStub: OnMissingStub.returnDefault),
])
void main() {}

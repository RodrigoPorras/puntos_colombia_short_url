import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:puntos_colombia_short_url/src/domain/models/repositories/database_repository.dart';
import 'package:puntos_colombia_short_url/src/domain/models/short_url.dart';

part 'local_short_urls_state.dart';

class LocalShortUrlsCubit extends Cubit<LocalShortUrlsState> {
  final DatabaseRepository _databaseRepository;

  LocalShortUrlsCubit(this._databaseRepository)
      : super(LocalShortUrlsLoading());

  Future<void> getAllSavedShortUrls() async {
    emit(await _getAllSavedShortUrls());
  }

  Future<void> saveShortUrl({required ShortUrl shortUrl}) async {
    await _databaseRepository.saveShortUrl(shortUrl);
    emit(await _getAllSavedShortUrls());
  }

  Future<LocalShortUrlsState> _getAllSavedShortUrls() async {
    final urlsHistory = await _databaseRepository.getUrlsHistory();
    return LocalShortUrlsSuccess(allUrlsHistory: urlsHistory);
  }
}

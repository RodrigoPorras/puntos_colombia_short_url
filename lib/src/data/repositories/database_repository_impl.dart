import 'package:puntos_colombia_short_url/src/data/datasources/local/app_database.dart';
import 'package:puntos_colombia_short_url/src/domain/models/repositories/database_repository.dart';
import 'package:puntos_colombia_short_url/src/domain/models/short_url.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  final AppDatabase _appDatabase;

  DatabaseRepositoryImpl(this._appDatabase);

  @override
  Future<List<ShortUrl>> getUrlsHistory() {
    return _appDatabase.urlsHistoryDao.getAllUrlsHistory();
  }

  @override
  Future<void> saveShortUrl(ShortUrl shortUrl) {
    return _appDatabase.urlsHistoryDao.insertShortUrl(shortUrl);
  }
}

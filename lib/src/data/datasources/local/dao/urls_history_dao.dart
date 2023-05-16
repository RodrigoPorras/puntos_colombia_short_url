
import 'package:floor/floor.dart';
import 'package:puntos_colombia_short_url/src/domain/models/short_url.dart';
import 'package:puntos_colombia_short_url/src/utils/constants/strings.dart';

@dao
abstract class UrlsHistoryDao {
  @Query('SELECT * FROM $urlsHistoryTableName')
  Future<List<ShortUrl>> getAllUrlsHistory();

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertShortUrl(ShortUrl shortUrl);
}
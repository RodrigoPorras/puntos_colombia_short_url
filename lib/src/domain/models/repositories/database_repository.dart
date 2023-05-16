import 'package:puntos_colombia_short_url/src/domain/models/short_url.dart';

abstract class DatabaseRepository {
  Future<List<ShortUrl>> getUrlsHistory();

  Future<void> saveShortUrl(ShortUrl shortUrl);
}

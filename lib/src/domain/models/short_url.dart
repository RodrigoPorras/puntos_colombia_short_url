import 'package:floor/floor.dart';
import 'package:puntos_colombia_short_url/src/utils/constants/strings.dart';

@Entity(tableName: urlsHistoryTableName)
class ShortUrl {
  @primaryKey
  final String original;
  final String short;

  ShortUrl(this.original, this.short);
}
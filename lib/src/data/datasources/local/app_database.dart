import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:puntos_colombia_short_url/src/data/datasources/local/dao/urls_history_dao.dart';
import 'package:puntos_colombia_short_url/src/domain/models/short_url.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [ShortUrl])
abstract class AppDatabase extends FloorDatabase {
  UrlsHistoryDao get urlsHistoryDao;
}

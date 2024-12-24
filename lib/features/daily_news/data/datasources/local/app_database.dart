import 'dart:async';

import 'package:floor/floor.dart';
import 'package:news/features/daily_news/data/datasources/local/dao/article_dao.dart';
import 'package:news/features/daily_news/data/models/article.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [ArticleModel])
abstract class AppDatabase extends FloorDatabase {
  ArticleDao get articleDao;
}

// final migration1to2 = Migration(1, 2, (database) async {
//   await database.execute('ALTER TABLE ArticleModel ADD COLUMN id INTEGER');
//   await database.execute('ALTER TABLE article RENAME TO ArticleModel');
// });

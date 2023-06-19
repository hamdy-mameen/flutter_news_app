import 'package:news_app/models/article.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static const _databaseName = 'news.db';
  static const _version = 1;
  static const tableName = 'article_tabel';
  static Future<Database> _openDb() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(join(dbPath, _databaseName),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE $tableName(id INTEGER PRIMARY KEY,author TEXT,title TEXT,description TEXT,url TEXT,urlToImage TEXT,content TEXT,publishedAt TEXT)');
    }, version: _version);
  }

  static Future<int> insertArticle(Article article) async {
    final db = await _openDb();
    return await db.insert(tableName, article.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteArticle(Article article) async {
    final db = await _openDb();
    return await db.delete(tableName, where: 'id = ?', whereArgs: [article.id]);
  }

  static Future<List<Article>?> getAllArticles() async {
    final db = await _openDb();
    List<Map<String, dynamic>> list = await db.query(tableName);
    if (list.isEmpty) {
      return null;
    }
    return List.generate(list.length, (index) => Article.fromJson(list[index]));
  }
}

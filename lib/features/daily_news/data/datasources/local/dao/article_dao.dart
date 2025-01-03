import 'package:floor/floor.dart';
import 'package:news/features/daily_news/data/models/article.dart';

@dao
abstract class ArticleDao {
  //insert delete get
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertArticle(ArticleModel article);

  @delete
  Future<void> deleteArticle(ArticleModel article);

  @Query('SELECT * FROM article')
  Future<List<ArticleModel>> getArticles();
}

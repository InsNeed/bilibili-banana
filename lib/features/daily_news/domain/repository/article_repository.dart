import 'package:news/core/resources/data_state.dart';
import 'package:news/features/daily_news/domain/entityies/articel.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getNewsArticles();
}

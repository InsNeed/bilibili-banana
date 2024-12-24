import 'dart:io';
import 'package:news/constants/constants.dart';
import 'package:news/core/resources/data_state.dart';
import 'package:news/features/daily_news/data/datasources/local/app_database.dart';
import 'package:news/features/daily_news/data/datasources/remote/news_api_serivce.dart';
import 'package:news/features/daily_news/data/models/article.dart';
import 'package:news/features/daily_news/domain/entityies/articel.dart';
import 'package:news/features/daily_news/domain/repository/article_repository.dart';
import 'package:dio/dio.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiSerivce _newsApiSerivce;
  final AppDatabase _appDatabase;

  ArticleRepositoryImpl(this._newsApiSerivce, this._appDatabase);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      final httpResponse = await _newsApiSerivce.getNewsArticles();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        // print(httpResponse.data);
        return DataSuccess(httpResponse.data);
      } else {
        // print('nooo');
        return DataFailed(DioError(
          requestOptions: httpResponse.response.requestOptions,
          response: httpResponse.response,
          error: httpResponse.response.statusMessage,
          type: DioErrorType.response,
        ));
      }
    } on DioError catch (e) {
      //有更多详情
      return DataFailed(e);
    }
  }

  @override
  Future<List<ArticleModel>> getSavedArticles() {
    return _appDatabase.articleDao.getArticles();
  }

  @override
  Future<void> removeArticle(ArticleEntity article) {
    return _appDatabase.articleDao
        .deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<void> saveArticle(ArticleEntity article) {
    return _appDatabase.articleDao.insertArticle(ArticleModel.fromEntity(article));
  }

}

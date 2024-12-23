import 'dart:io';
import 'package:news/constants/constants.dart';
import 'package:news/features/daily_news/data/models/article.dart';
import 'package:news/features/daily_news/domain/entityies/articel.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'news_api_serivce.g.dart';

@RestApi(baseUrl: newsApiBaseUrl)
abstract class NewsApiSerivce {
  factory NewsApiSerivce(Dio dio) = _NewsApiSerivce;

  @GET('bili')
  Future<HttpResponse<List<ArticleModel>>> getNewsArticles();
}

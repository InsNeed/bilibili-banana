import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:news/features/daily_news/data/datasources/remote/news_api_serivce.dart';
import 'package:news/features/daily_news/data/repository/article_repository.dart';
import 'package:news/features/daily_news/domain/entityies/articel.dart';
import 'package:news/features/daily_news/domain/repository/article_repository.dart';
import 'package:news/features/daily_news/domain/usecases/get_article.dart';
import 'package:news/features/daily_news/presentatsion/bloc/article/remote/remote_article_bloc.dart';

final sl = GetIt.instance; //service locator 用于注册和检索应用服务

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio());
  sl.registerSingleton<NewsApiSerivce>(
      NewsApiSerivce(sl())); //本来是dio,现在可以用sl()来代替
  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(
      sl())); //依赖注入需要具体实例而不是抽象类，这里是表示 当应用需要一个ArticleRepository的单例时,它会使用ArticleRepositoryImpl的实例。

  // 注册 UseCase
  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));

  //bloc会在更新时返回新的实例,这里用Factory
  sl.registerFactory<RemoteArticleBloc>(() => RemoteArticleBloc(sl()));
}

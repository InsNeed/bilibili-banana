part of 'local_article_bloc.dart';

// import 'package:equatable/equatable.dart';
// import 'package:news/features/daily_news/domain/entityies/articel.dart';

class LocalArticlesState extends Equatable {
  final List<ArticleEntity>? articles;

  const LocalArticlesState({this.articles});

  @override
  List<Object> get props => [
        {this.articles}
      ];
}

final class LocalArticlesInitial extends LocalArticlesState {}

final class LocalArticlesLoading extends LocalArticlesState {
  const LocalArticlesLoading();
}

final class LocalArticlesDone extends LocalArticlesState {
  const LocalArticlesDone(List<ArticleEntity> articles)
      : super(articles: articles);
}

part of 'local_article_bloc.dart';

sealed class LocalArticlesEvent extends Equatable {
  final ArticleEntity? articel;
  const LocalArticlesEvent({this.articel});
  @override
  List<Object> get props => [articel!];
}

class GetSavedArticles extends LocalArticlesEvent {
  const GetSavedArticles();
}

class RemoveArticle extends LocalArticlesEvent {
  const RemoveArticle(ArticleEntity articel) : super(articel: articel);
}

class SaveArticle extends LocalArticlesEvent {
  const SaveArticle(ArticleEntity articel) : super(articel: articel);
}


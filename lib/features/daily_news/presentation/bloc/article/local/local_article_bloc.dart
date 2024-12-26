import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:news/features/daily_news/domain/entityies/articel.dart';
import 'package:news/features/daily_news/domain/repository/article_repository.dart';
import 'package:news/features/daily_news/domain/usecases/articles/get_saved_article.dart';
import 'package:news/features/daily_news/domain/usecases/articles/remove_article.dart';
import 'package:news/features/daily_news/domain/usecases/articles/save_article.dart';
import 'package:news/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';

part 'local_article_event.dart';
part 'local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticlesEvent, LocalArticlesState> {
  final GetSavedArticleUseCase _getSavedArticlesUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;
  final SaveArticleUseCase _saveArticleUseCase;

  LocalArticleBloc(this._getSavedArticlesUseCase, this._removeArticleUseCase,
      this._saveArticleUseCase) //初始状态
      : super(const LocalArticlesLoading()) {
    on<GetSavedArticles>(onGetSavedArticles);
    on<RemoveArticle>(onRemoveArticle);
    on<SaveArticle>(onSaveArticle);
  }

  void onGetSavedArticles(
      GetSavedArticles event, Emitter<LocalArticlesState> emit) async {
    final articles = await _getSavedArticlesUseCase();
    emit(LocalArticlesDone(articles));
  }

  void onRemoveArticle(
      RemoveArticle removeArticle, Emitter<LocalArticlesState> emit) async {
    await _removeArticleUseCase(params: removeArticle.articel);
    final articles = await _getSavedArticlesUseCase();
    emit(LocalArticlesDone(articles));
  }

  void onSaveArticle(
      SaveArticle saveArticle, Emitter<LocalArticlesState> emit) async {
    await _saveArticleUseCase(params: saveArticle.articel);
    final articles = await _getSavedArticlesUseCase();
    emit(LocalArticlesDone(articles));
  }
}

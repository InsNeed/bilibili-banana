import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/resources/data_state.dart';
import 'package:news/features/daily_news/domain/usecases/get_article.dart';
import 'package:news/features/daily_news/presentatsion/bloc/article/remote/remote_article_event.dart';
import 'package:news/features/daily_news/presentatsion/bloc/article/remote/remote_article_state.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticleUseCase _getArticleUseCase; //只是引用没有执行

  RemoteArticleBloc(this._getArticleUseCase)
      : super(const RemoteArticleLoading()) {
    //调用父类的构造函数
    on<GetArticles>(_onGetArticles);
  }

  void _onGetArticles(
      GetArticles event, Emitter<RemoteArticleState> emit) async {
    final dataState = await _getArticleUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      // print('bloc:success');
      emit(RemoteArticleDone(dataState.data!));
      // print(dataState.data!);
    } else if (dataState is DataFailed) {
      emit(RemoteArticleError(dataState.error!));
    }
  }
}

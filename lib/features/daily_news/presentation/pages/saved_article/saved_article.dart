import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:news/features/daily_news/domain/entityies/articel.dart';
import 'package:news/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:news/features/daily_news/presentation/widgets/article_tile.dart';
import 'package:news/injection_containner.dart';

class SavedArticles extends HookWidget {
  const SavedArticles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalArticleBloc>()..add(const GetSavedArticles()),
      child: Scaffold(
        appBar: _buidlAppBar(),
        body: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buidlAppBar() {
    return AppBar(
      leading: Builder(
          builder: (context) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _onBackButtonTapped(context),
                child: const Icon(Icons.arrow_back),
              )),
      title: const Text('Saved Articles'),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<LocalArticleBloc, LocalArticlesState>(
        builder: (context, state) {
      if (state is LocalArticlesLoading) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      } else if (state is LocalArticlesDone) {
        return Row(
          children: [
            _buildArticlesList(state.articles!),
            // ElevatedButton(onPressed: , child: child)
          ],
        );
      }
      return Container();
    });
  }

  Widget _buildArticlesList(List<ArticleEntity> articles) {
    if (articles.isEmpty) {
      return const Center(
        child: Text('No articles saved'),
      );
    } else {
      return Expanded(
        // 使用 Expanded 而不是 Flexible
        child: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  // 为 Row 中的组件使用 Expanded，确保它们的宽度被限制
                  child: ArticleWidget(
                    articles: articles[index],
                    // isRemovable: true,
                    // onRemove: (article) => _onRemoveArticle(context, article),
                    // onArticlePressed: (article) => _onArticlePressed(context, article),
                  ),
                ),
                ElevatedButton(
                  onPressed: () =>
                      _onRemoveArticle(context, articles[index]), // 延迟执行
                  child: const Text('Remove'), // 按钮文本
                ),
              ],
            );
          },
        ),
      );
    }
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  void _onRemoveArticle(BuildContext context, ArticleEntity article) {
    BlocProvider.of<LocalArticleBloc>(context).add(RemoveArticle(article));
  }

  // void _onArticlePressed(BuildContext context, ArticleEntity articel) {
  //   Navigator.pushNamed(context, '/ArticleDetails', arguments: articel);
  // }
}

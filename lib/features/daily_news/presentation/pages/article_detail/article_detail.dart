import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:news/constants/constants.dart';
import 'package:news/features/daily_news/domain/entityies/articel.dart';
import 'package:news/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:news/injection_containner.dart';

class ArticleDetailsView extends HookWidget {
  final ArticleEntity? article;

  const ArticleDetailsView({Key? key, this.article});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LocalArticleBloc>(), // 添加括号来调用函数
      child: Scaffold(
        appBar: _buidlAppBar(context), // 添加括号来调用函数
        body: _buildBody(), // 添加括号来调用函数
        floatingActionButton: _buildFloatingActionButton(context), // 添加括号来调用函数
      ),
    );
  }

  PreferredSizeWidget _buidlAppBar(BuildContext context) {
    return AppBar(
      leading: Builder(
          builder: (context) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _onBackButtonTapped(context),
                child: const Icon(
                  Icons.chevron_left_outlined,
                ),
              )),
      title: Text(article!.title!),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildArticleTitleAndDate(),
          _buildArticleImage(),
          _buildArticleDescription(),
        ],
      ),
    );
  }

  Widget _buildArticleTitleAndDate() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(article!.title!, style: const TextStyle(fontSize: 20)),
            const SizedBox(
              height: 14,
            ),
            Row(
              children: [
                const Icon(
                  Icons.timer_outlined,
                  size: 16,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  article!.hot!,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            )
          ],
        ));
  }

  Widget _buildArticleImage() {
    return Container(
      width: double.maxFinite,
      height: 250,
      margin: const EdgeInsets.only(top: 14),
      child: Image.network(
        banana,
        fit: BoxFit.cover,
      ),
      //TODO:shold be url to image
    );
  }

  Widget _buildArticleDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
      child: Text(
        '${article!.title! ?? ''} \n\n${article!.title ?? ''}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return Builder(
        builder: (context) => FloatingActionButton(
              onPressed: () => _onFloatingActionButtonPressed(context),
              child: const Icon(
                Icons.bookmark,
              ),
            ));
  }

  void _onFloatingActionButtonPressed(BuildContext context) {
    BlocProvider.of<LocalArticleBloc>(context).add(SaveArticle(article!));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Saved')),
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }
}

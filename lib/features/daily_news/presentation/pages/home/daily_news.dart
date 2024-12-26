import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/daily_news/domain/entityies/articel.dart';
import 'package:news/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:news/features/daily_news/presentation/bloc/theme/bloc/theme_bloc.dart';
import 'package:news/features/daily_news/presentation/bloc/theme/bloc/theme_event.dart';
import 'package:news/features/daily_news/presentation/bloc/theme/bloc/theme_state.dart';
import 'package:news/features/daily_news/presentation/pages/article_detail/article_detail.dart';
import 'package:news/features/daily_news/presentation/pages/saved_article/saved_article.dart';
import 'package:news/features/daily_news/presentation/widgets/article_tile.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Daily News',
        style: TextStyle(),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return SavedArticles();
            }));
          },
          icon: const Icon(
            Icons.menu,
          ),
        ),
        BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            final isLightTheme = state.themeData == ThemeData.light();
            return IconButton(
              onPressed: () {
                context.read<ThemeBloc>().add(ToggleThemeEvent());
              },
              icon: Icon(
                isLightTheme ? Icons.light_mode : Icons.dark_mode,
              ),
            );
          },
        ),
      ],
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
        builder: (_, dataState) {
      if (dataState is RemoteArticleLoading) {
        return const Center(
            child:
                CupertinoActivityIndicator()); //or CircularProgressIndicator()
      }
      if (dataState is RemoteArticleError) {
        print(dataState.error!.message);
        return const Center(
          child: Icon(Icons.refresh),
        );
      }
      if (dataState is RemoteArticleDone) {
        return ListView.builder(itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _onArticlePressed(context, dataState.articles![index]),
            child: ArticleWidget(
              articles: dataState.articles![index],
              onArticlePressed: (article) =>
                  _onArticlePressed(context, article),
            ),
          );
        });
      }
      return const SizedBox();
    });
  }

  void _onArticlePressed(BuildContext context, ArticleEntity articel) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return ArticleDetailsView(article: articel);
    }));
  }
}

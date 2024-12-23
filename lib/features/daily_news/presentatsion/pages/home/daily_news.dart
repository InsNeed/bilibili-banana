import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/daily_news/presentatsion/bloc/article/remote/remote_article_bloc.dart';
import 'package:news/features/daily_news/presentatsion/bloc/article/remote/remote_article_state.dart';
import 'package:news/features/daily_news/presentatsion/widgets/article_tile.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
        title: const Text('Daily News',
            style: TextStyle(
              color: Colors.black,
            )));
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
          return ArticleWidget(
            articles: dataState.articles![index],
          );
        });
      }
      return const SizedBox();
    });
  }
}

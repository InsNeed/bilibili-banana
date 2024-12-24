import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:news/config/theme/app_themes.dart';
import 'package:news/features/daily_news/data/datasources/local/app_database.dart';
import 'package:news/features/daily_news/data/datasources/local/dao/article_dao.dart';
import 'package:news/features/daily_news/presentatsion/bloc/article/remote/remote_article_bloc.dart';
import 'package:news/features/daily_news/presentatsion/bloc/article/remote/remote_article_event.dart';
import 'package:news/features/daily_news/presentatsion/pages/home/daily_news.dart';
import 'injection_containner.dart';
import 'package:dio/dio.dart';

//temp
import 'package:http/http.dart' as http;
import 'dart:convert';

//注意要加future
Future<void> main() async {
  // var data = await fetchData();
  // print(data);
  await initializeDependencies();
  WidgetsFlutterBinding.ensureInitialized(); //确保数据库完全初始化


  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticleBloc>(
      //TODO:why?
      // create: (context) => BlocProvider.of<RemoteArticleBloc>(context)..add(GetArticles()),
      create: (context) => sl()..add(GetArticles()),

      child: MaterialApp(
        theme: theme(),
        debugShowCheckedModeBanner: false,
        home: const DailyNews(),
      ),
    );
  }
}

// Future<List<Map<String, String>>> fetchData() async {
//   String? url = "https://api.vvhan.com/api/hotlist/bili";

//   // 发送HTTP GET请求
//   final response = await http.get(Uri.parse(url));

//   if (response.statusCode == 200) {
//     // 如果请求成功，解析返回的JSON数据
//     final Map<String, dynamic> data = json.decode(response.body);

//     List<dynamic> resblockData = data['data'];

//     List<Map<String, String>> result = resblockData.map((item) {
//       return {
//         'title': item['title']?.toString() ?? '无名称',
//         'hot': item['hot']?.toString() ?? '无',
//         'url': item['https://b23.tv/BV12SkuYUEz9']?.toString() ?? '无',
//         'index': item['index']?.toString() ?? '无',
//       };
//     }).toList();

//     return result;
//   } else {
//     // 如果请求失败，抛出异常
//     throw Exception('Failed to load data');
//   }
// }

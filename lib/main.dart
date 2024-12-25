import 'package:desktop_window/desktop_window.dart';
import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:news/config/theme/app_themes.dart';
import 'package:news/features/daily_news/data/datasources/local/app_database.dart';
import 'package:news/features/daily_news/data/datasources/local/dao/article_dao.dart';
import 'package:news/features/daily_news/presentatsion/bloc/article/remote/remote_article_bloc.dart';
import 'package:news/features/daily_news/presentatsion/bloc/article/remote/remote_article_event.dart';
import 'package:news/features/daily_news/presentatsion/bloc/theme/bloc/theme_bloc.dart';
import 'package:news/features/daily_news/presentatsion/bloc/theme/bloc/theme_state.dart';
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

  _setWindowSize();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RemoteArticleBloc>(
            create: (context) => sl()..add(GetArticles())), //将状态添加并触发
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            theme: themeState.themeData, // 使用 ThemeBloc 中的主题数据
            debugShowCheckedModeBanner: false,
            home: const DailyNews(),
            themeMode: ThemeMode.system,
          );
        },
      ),
    );
  }
}

void _setWindowSize() {
  if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.windows)) {
    // 设置初始窗口大小，单位为像素
    DesktopWindow.setWindowSize(const Size(600, 900)); // 设置窗口大小为800x600
    DesktopWindow.setMinWindowSize(const Size(600, 900)); // 设置窗口最小大小
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

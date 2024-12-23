import 'package:news/features/daily_news/domain/entityies/articel.dart';

class ArticleModel extends ArticleEntity {
  const ArticleModel({
    required String title,
    required String hot,
    required String url,
    required String mobileUrl,
  }) : super(
          title: title,
          hot: hot,
          url: url,
          mobileUrl: mobileUrl,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] ?? '无标题', // 确保不会传递 null
      hot: json['hot'] ?? '无热度', // 给字段默认值
      url: json['url'] ?? '',
      mobileUrl: json['mobileUrl'] ?? '',
    );
  }
}

import 'package:floor/floor.dart';
import 'package:news/features/daily_news/domain/entityies/articel.dart';

@Entity(tableName: 'article')
class ArticleModel extends ArticleEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id; // 自动生成的 ID

  const ArticleModel({
    this.id,
    super.title,
    super.hot,
    super.url,
    super.mobileUrl,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] ?? '无标题', // 确保不会传递 null
      hot: json['hot'] ?? '无热度', // 给字段默认值
      url: json['url'] ?? '',
      mobileUrl: json['mobileUrl'] ?? '',
    );
  }

  factory ArticleModel.fromEntity(ArticleEntity entity) {
    return ArticleModel(
        id: entity.id,
        title: entity.title,
        hot: entity.hot,
        url: entity.url,
        mobileUrl: entity.mobileUrl);
  }
}

import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final String? title;
  final String? hot;
  final String? url;
  final String? mobileUrl;

  const ArticleEntity({
    this.title,
    this.hot,
    this.url,
    this.mobileUrl,
  });

  @override
  List<Object?> get props => [
        title,
        hot,
        url,
        mobileUrl,
      ];
}

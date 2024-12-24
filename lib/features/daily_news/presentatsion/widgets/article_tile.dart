import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news/constants/constants.dart';
import 'package:news/features/daily_news/domain/entityies/articel.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleEntity? articles;
  final bool isRemovable;
  final Function(ArticleEntity)? onRemove;
  final Function(ArticleEntity)? onArticlePressed;

  const ArticleWidget(
      {Key? key,
      this.articles,
      this.isRemovable = false,
      this.onRemove,
      this.onArticlePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(
          start: 14, end: 14, bottom: 14, top: 14),
      height: MediaQuery.of(context).size.width / 2.2,
      child: Row(
        children: [
          _buildImage(context),
          _buildTitleAndDiscription(),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return CachedNetworkImage(
        //TODO:shold be articles!.urlToImage!
        imageUrl: banana,
        imageBuilder: (context, imageProvider) => Padding(
              padding: const EdgeInsetsDirectional.only(end: 14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.08),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
              ),
            ),
        progressIndicatorBuilder: (context, url, downloadProgress) => Container(
              padding: const EdgeInsetsDirectional.only(end: 14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: double.maxFinite,
                  child: const CircularProgressIndicator(),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.08),
                  ),
                ),
              ),
            ),
        errorWidget: (context, url, error) => Padding(
              padding: const EdgeInsetsDirectional.only(end: 14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.08)),
                  child: const Icon(Icons.error),
                ),
              ),
            ));
  }

  Widget _buildTitleAndDiscription() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min, //尽可能小不占据其他
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(articles!.title!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  fontFamily: 'Butler')),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              articles!.hot ?? '',
              maxLines: 2,
            ),
          )),
          Row(
            children: [
              const Icon(Icons.timeline_outlined, size: 16),
              const SizedBox(
                width: 4,
              ),
              Flexible(
                child: Text(
                  articles!.title!,
                  style: const TextStyle(fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

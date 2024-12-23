// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_api_serivce.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _NewsApiSerivce implements NewsApiSerivce {
  _NewsApiSerivce(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://api.vvhan.com/api/hotlist/bili';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<List<ArticleModel>>> getNewsArticles() async {
    final _headers = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<List<ArticleModel>>>(Options(
      method: 'GET',
      headers: _headers,
    ).compose(
      _dio.options,
      'https://api.vvhan.com/api/hotlist/bili',
    )));

    print(_result.data!['data']);
    List<dynamic> articlesData = _result.data!['data'];
    // List<ArticleModel> value = _result.data!['data']!
    //     .map((dynamic i) => ArticleModel.fromJson(i as Map<String, dynamic>)).toList();
    List<ArticleModel> value = articlesData.map((dynamic i) {
      print("Mapping article: $i"); // 打印每个元素，确保它是一个 Map<String, dynamic>
      return ArticleModel.fromJson(i as Map<String, dynamic>);
    }).toList();
    print("value:");
    print(value);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}

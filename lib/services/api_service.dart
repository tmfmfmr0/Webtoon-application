// 사용 API :
// https://webtoon-crawler.nomadcoders.workers.dev/
// https://webtoon-crawler.nomadcoders.workers.dev/today
// https://webtoon-crawler.nomadcoders.workers.dev/#id
// https://webtoon-crawler.nomadcoders.workers.dev/#id/episodes

// API 제작 html rewriter 파싱 : https://developers.cloudflare.com/workers/runtime-apis/html-rewriter/

// Dart Flutter Packages : https://pub.dev/

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/models/webtoon_model.dart';

class APIService {
  static const String baseURL =
      'https://webtoon-crawler.nomadcoders.workers.dev';
  static const String today = 'today';

  // 오늘의 웹툰 리스트 fetching
  static Future<List<WebtoonModel>> getTodaysToons() async {
    final url = Uri.parse('$baseURL/$today');
    final response = await http.get(url);
    List<WebtoonModel> webtoonInstances = [];

    // json decode response body
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }

  // 웹툰 상세정보 fetching
  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseURL/$id');
    final response = await http.get(url);

    // json decode response body
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  // 웹툰 에피소드 fetching
  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    final url = Uri.parse('$baseURL/$id/episodes');
    final response = await http.get(url);
    List<WebtoonEpisodeModel> episodeInstances = [];

    // json decode response body
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodeInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodeInstances;
    }
    throw Error();
  }
}

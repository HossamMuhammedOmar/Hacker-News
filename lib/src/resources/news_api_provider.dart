import 'dart:convert';
import 'package:Hacker_News/src/models/item_model.dart';
import 'package:http/http.dart' as http;

class NewsApiProvider {
  final String _url = "https://hacker-news.firebaseio.com/v0";

  Future<List<int>> fetchTopIds() async {
    final response = await http.get("$_url/topstories.json");
    final listIds = json.decode(response.body);
    return listIds.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await http.get("$_url/item/$id.json");
    final parsedJson = json.decode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}

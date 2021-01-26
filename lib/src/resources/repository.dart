import 'package:Hacker_News/src/resources/news_api_provider.dart';
import 'package:Hacker_News/src/resources/news_db_provider.dart';

class Repository {
  NewsApiProvider apiProvider = NewsApiProvider();
  NewsDbProvider dbProvider = NewsDbProvider();

  fetchTopIds() {
    return apiProvider.fetchTopIds();
    // List Of Ids
  }

  fetchItem(int id) async {
    var item = await dbProvider.fetchItem(id);
    if (item != null) {
      return item;
    }

    item = await apiProvider.fetchItem(id);
    dbProvider.addItem(item);

    return item;
  }
}

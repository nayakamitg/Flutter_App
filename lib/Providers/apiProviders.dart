import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiProviders extends ChangeNotifier {
  int _page = 1;
  final int _pageSize = 20;
  var _counter = 1;

  int getpage() => _counter;

  List<dynamic> _persons = [];
  List<dynamic> get persons => _persons;

  List<dynamic> _categories = [];
  List<dynamic> get categories => _categories;

  static final String _baseUrl = "https://goplanup.dishaayein.com/api";

  bool isLoading = false;

  ApiProviders() {
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    await Future.wait([getPersons(), getCategories()]);
  }

  Future<void> getPersons() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse(
      "$_baseUrl/MissingPersons?PageSize=$_pageSize&PageNumber=$_page",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List<dynamic> newData = jsonData["data"];

      // Process images and add fallback
      for (var person in newData) {
        if (person["images"] == null || person["images"].isEmpty) {
          person["images"] = [
            {
              "imageUrl":
                  "https://thumbs.dreamstime.com/b/no-image-available-like-missing-picture-no-image-available-like-missing-picture-linear-flat-simple-style-modern-logotype-graphic-255657435.jpg",
            },
          ];
        } else {
          for (var image in person["images"]) {
            image["imageUrl"] =
                "https://goplanup.dishaayein.com${image["imageUrl"]}";
          }
        }
      }

      _persons = newData;
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> getCategories() async {
    final url = Uri.parse("$_baseUrl/Category");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      _categories = json.decode(response.body);
      notifyListeners();
    } else {
      throw Exception("Failed to load categories");
    }
  }

  void nextData() {
    _counter++;
    _page = _page + 20;
    getPersons(); // Automatically fetches next page
  }

  void prevData() {
    _counter--;
    _page = _page - 20;
    getPersons(); // Automatically fetches next page
  }

  static Future<List<dynamic>> cat_api() async {
    final response = await http.get(Uri.parse("$_baseUrl/Category"));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Category not Found");
    }
  }

  static Future<Map<String, dynamic>> apicall() async {
    final response = await http.get(Uri.parse("$_baseUrl/MissingPersons"));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load data');
  }

  Future<Map<String, dynamic>> getApiDetails() async {
    var data = await apicall();
    data = data["data"];
    return {};
  }

 static deadBodies() async {
    var deadBodiesData = await http.get(
      Uri.parse("https://goplanup.dishaayein.com/api/UnIdentifiedDeadBodies"),
    );
    if (deadBodiesData.statusCode == 200) {
      return json.decode(deadBodiesData.body);
    }
    throw Exception("Failed to load data");
  }
}

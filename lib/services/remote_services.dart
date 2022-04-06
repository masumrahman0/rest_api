import 'dart:convert';
import '../models/post.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  Future<List<Post>?> getPosts() async {
    var client = http.Client();
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/users/1/posts');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return postFromJson(json);
    }
  }

  Future addPosts(title) async {
    var response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/users/1/posts'),
        headers: {"Content-Types": "application.json"},
        body: jsonEncode({'title': title}));

        print(response.body);
  }
}

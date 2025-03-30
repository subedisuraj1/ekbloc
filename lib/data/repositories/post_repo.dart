import 'package:dio/dio.dart';
import 'package:ekbloc/data/models/post_models.dart';
import 'package:ekbloc/data/repositories/api/api.dart';

class PostRepo {
  API api = API();
  Future<List<PostModels>> fetchPosts() async {
    try {
      Response response = await api.sendRequest.get("/posts");
      List<dynamic> postMaps = response.data;
     return postMaps.map((postMap)=> PostModels.fromJson(postMap)).toList();
    } catch (e) {
      throw e;
    }
  }
}

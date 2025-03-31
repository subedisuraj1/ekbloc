import 'package:dio/dio.dart';
import 'package:ekbloc/data/models/image_models.dart';
import 'package:ekbloc/data/repositories/api/api.dart';

class ImageRepo {
  API api = API();

  Future<List<ImageModels>> fetchImages() async {
    try {
      Response response = await api.sendRequest.get("/photos");
      List<dynamic> imageMaps = response.data;
      return imageMaps
          .map((imageMap) => ImageModels.fromJson(imageMap))
          .toList();
    } catch (e) {
      throw e;
    }
  }
}

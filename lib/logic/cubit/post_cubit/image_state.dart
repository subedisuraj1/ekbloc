import 'package:ekbloc/data/models/image_models.dart';

abstract class ImageState {}

class ImageLoadingState extends ImageState {}

class ImageLoadedState extends ImageState {
  final List<ImageModels> imageUrl;
  ImageLoadedState(this.imageUrl);
}

class ImageErrorState extends ImageState {
  final String error;
  ImageErrorState(this.error);
}

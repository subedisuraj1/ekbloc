import 'package:ekbloc/data/models/post_models.dart';

abstract class PostState {}

class postLoadingState extends PostState {}

class postLoadedState extends PostState {
  final List<PostModels> posts;
  postLoadedState(this.posts);
}

class postErrorState extends PostState {
  final String error;
  postErrorState(this.error);
}


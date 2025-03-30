import 'package:dio/dio.dart';
import 'package:ekbloc/data/models/post_models.dart';
import 'package:ekbloc/data/repositories/post_repo.dart';
import 'package:ekbloc/logic/cubit/post_cubit/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(postLoadingState()) {
    fetchPosts();
  }

  void fetchPosts() async {
    try {
      List<PostModels> posts = await PostRepo().fetchPosts();
      emit(
        postLoadedState(posts),
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        emit(postErrorState("No Internet Connection"));
      } else {
        emit(postErrorState(e.message ?? "Something went wrong"));
      }
    }
  }
}

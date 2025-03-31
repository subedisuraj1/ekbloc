import 'package:dio/dio.dart';
import 'package:ekbloc/data/models/image_models.dart';
import 'package:ekbloc/data/repositories/api/image_repo.dart';
import 'package:ekbloc/logic/cubit/post_cubit/image_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(ImageLoadingState()) {
    fetchImages();
  }

  void fetchImages() async {
    try {
      List<ImageModels> images = await ImageRepo().fetchImages();
      emit(ImageLoadedState(images));
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        emit(ImageErrorState("No Internet Connection"));
      } else {
        emit(ImageErrorState(e.message ?? "Something went wrong"));
      }
    }
  }
}

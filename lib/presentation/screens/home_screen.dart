import 'package:carousel_slider/carousel_slider.dart';
import 'package:ekbloc/data/models/post_models.dart';
import 'package:ekbloc/logic/cubit/image_cubit.dart';
import 'package:ekbloc/logic/cubit/post_cubit/image_state.dart';
import 'package:ekbloc/logic/cubit/post_cubit/post_cubit.dart';
import 'package:ekbloc/logic/cubit/post_cubit/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text(
          'Gallery & posts',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<ImageCubit, ImageState>(
            builder: (context, state) {
              if (state is ImageLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ImageLoadedState) {
                return CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    enableInfiniteScroll: true,
                  ),
                  items: state.imageUrl.map((image) {
                    return Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 5),
                        ],
                      ),
                      child: ClipRect(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(image.title!),
                            Image.network(image.url!),
                            Text(image.id.toString()),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              } else if (state is ImageErrorState) {
                return Center(
                  child: Text(
                    state.error,
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }
              return Container();
            },
          ),
          Expanded(
            child: BlocConsumer<PostCubit, PostState>(
              listener: (context, state) {
                if (state is postErrorState) {
                  SnackBar snackbar = SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }
              },
              builder: (context, state) {
                if (state is postLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is postLoadedState) {
                  return buildPostListView(state.posts);
                }
                return Center(
                  child: Text("An error occured!"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPostListView(List<PostModels> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        PostModels post = posts[index];
        return ListTile(
          title: Text(
            post.title.toString(),
          ),
          subtitle: Text(
            post.body.toString(),
          ),
        );
      },
    );
  }
}

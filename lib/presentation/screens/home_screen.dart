import 'package:ekbloc/data/models/post_models.dart';
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
          'Api Handling',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
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

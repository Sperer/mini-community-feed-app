import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_community_feed_app/feature/presentation/Bloc/post/post_bloc.dart';
import 'package:mini_community_feed_app/feature/presentation/Bloc/post/post_event.dart';
import 'package:mini_community_feed_app/feature/presentation/Bloc/post/post_state.dart';
import 'package:mini_community_feed_app/feature/presentation/Bloc/reaction/reaction_bloc.dart';
import 'package:mini_community_feed_app/feature/presentation/Bloc/reaction/reaction_event.dart';
import 'package:mini_community_feed_app/feature/presentation/Bloc/reaction/reaction_state.dart';
import 'package:mini_community_feed_app/feature/presentation/widgets/post_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<PostBloc>().add(GetPostEvent());
    context.read<ReactionBloc>().add(GetReactionsEvent());
    super.initState();
  }

  // Function to refresh the feed
  Future<void> _onRefresh() async {
    // Dispatch event to reload posts
    context.read<PostBloc>().add(GetPostEvent());
    // You can also await completion if your bloc exposes a Future
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mini Community'),
        backgroundColor: Colors.grey.shade400,
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: Colors.grey.shade400,
        backgroundColor: Colors.white,
        strokeWidth: 3,
        child: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
          switch (state) {
            case GetPostLoadingState _:
              return Center(
                  child:
                      CircularProgressIndicator(color: Colors.grey.shade400));
            case GetPostSuccess _:
              return ListView.builder(
                  cacheExtent: 5000,
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    return BlocBuilder<ReactionBloc, ReactionState>(
                        builder: (context, reactionState) {
                      switch (reactionState) {
                        case ReactionLoadedState _:
                          return PostWidget(
                              isLiked: reactionState.likedPostIds
                                  .contains(state.posts[index].id),
                              id: state.posts[index].id,
                              caption: state.posts[index].title,
                              thumbnailUrl: state.posts[index].url);
                        default:
                          return SizedBox.shrink();
                      }
                    });
                  });
            case GetPostFailure _:
              return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: const Center(
                      child: Text('Something Went Wrong!'),
                    ),
                  ));
            default:
              return SizedBox.shrink();
          }
        }),
      ),
    );
  }
}

import 'package:mini_community_feed_app/feature/domain/entities/post.dart';

abstract class PostState {}

class InitPostState extends PostState {}

class GetPostLoadingState extends PostState {}

class GetPostSuccess extends PostState {
  final List<Post> posts;
  GetPostSuccess(this.posts);
}

class GetPostFailure extends PostState {}

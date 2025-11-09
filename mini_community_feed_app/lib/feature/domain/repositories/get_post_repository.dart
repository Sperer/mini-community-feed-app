import 'package:mini_community_feed_app/core/typedef/typedef.dart';
import 'package:mini_community_feed_app/feature/domain/entities/post.dart';

abstract class GetPostRepository {
  ResultFuture<List<Post>> getPosts();
}

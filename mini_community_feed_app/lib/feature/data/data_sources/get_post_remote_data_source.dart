import 'package:mini_community_feed_app/feature/data/models/post_model.dart';

abstract class GetPostRemoteDataSource {
  Future<List<PostModel>> getPosts();
}

import 'package:mini_community_feed_app/core/typedef/typedef.dart';
import 'package:mini_community_feed_app/core/usecase/usecase.dart';
import 'package:mini_community_feed_app/feature/domain/entities/post.dart';
import 'package:mini_community_feed_app/feature/domain/repositories/get_post_repository.dart';

class GetPostUsecase extends Usecase<ResultFuture<List<Post>>, void> {
  final GetPostRepository getPostRepository;
  GetPostUsecase({required this.getPostRepository});

  @override
  ResultFuture<List<Post>> call({void param}) {
    return getPostRepository.getPosts();
  }
}

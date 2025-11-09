import 'package:bloc/bloc.dart';
import 'package:mini_community_feed_app/feature/domain/usecases/get_post_usecase.dart';
import 'package:mini_community_feed_app/feature/presentation/Bloc/post/post_event.dart';
import 'package:mini_community_feed_app/feature/presentation/Bloc/post/post_state.dart';

/// Bloc that manages fetching posts using [GetPostUsecase] 
/// and emits loading, success, or failure states.
class PostBloc extends Bloc<PostEvent, PostState> {
  GetPostUsecase getPostUsecase;

  PostBloc(this.getPostUsecase) : super(InitPostState()) {
    on<GetPostEvent>((event, emit) async {
      emit(GetPostLoadingState());
      final result = await getPostUsecase.call();
      result.fold((error) => emit(GetPostFailure()),
          (posts) => emit(GetPostSuccess(posts)));
    });
  }
}

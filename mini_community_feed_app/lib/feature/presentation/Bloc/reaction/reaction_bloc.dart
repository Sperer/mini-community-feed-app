import 'package:bloc/bloc.dart';
import 'package:mini_community_feed_app/feature/presentation/Bloc/reaction/reaction_event.dart';
import 'package:mini_community_feed_app/feature/presentation/Bloc/reaction/reaction_state.dart';

/// ReactionBloc responsible for managing post reactions (like/unlike) in the app.
/// It maintains a set of liked post IDs and updates the UI based on user interactions.
/// Handles events to toggle likes and retrieve the current liked state of posts.
class ReactionBloc extends Bloc<ReactionEvent, ReactionState> {
  ReactionBloc() : super(InitReactionState()) {
    Set<int> likedPostIds = {};
    on<LikeReactionEvent>((event, emit) {
      emit(ReactionLoadingState());
      try {
        if (!likedPostIds.contains(event.id)) {
          likedPostIds.add(event.id);
          emit(ReactionSuccessState(true));
        } else {
          likedPostIds.remove(event.id);
          emit(ReactionSuccessState(false));
        }
        emit(ReactionLoadedState(likedPostIds));
      } catch (ex) {
        emit(ReactionFailureState());
      }
    });

    on<GetReactionsEvent>((event, emit) {
      emit(ReactionLoadingState());
      try {
        emit(ReactionLoadedState(likedPostIds));
      } catch (ex) {
        emit(ReactionFailureState());
      }
    });
  }
}

abstract class ReactionState {}

class InitReactionState extends ReactionState {}

class ReactionLoadingState extends ReactionState {}

class ReactionLoadedState extends ReactionState {
  Set<int> likedPostIds;
  ReactionLoadedState(this.likedPostIds);
}

class ReactionSuccessState extends ReactionState {
  bool isLiked;
  ReactionSuccessState(this.isLiked);
}

class ReactionFailureState extends ReactionState {}

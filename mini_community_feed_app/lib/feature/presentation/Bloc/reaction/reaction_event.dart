abstract class ReactionEvent {}

class GetReactionsEvent extends ReactionEvent {}

class LikeReactionEvent extends ReactionEvent {
  int id;
  LikeReactionEvent(this.id);
}

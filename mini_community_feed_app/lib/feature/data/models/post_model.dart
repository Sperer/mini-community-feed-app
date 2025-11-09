import 'package:mini_community_feed_app/feature/domain/entities/post.dart';

/// Data model class representing a Post, extending the domain-level [Post] entity.
/// Provides factory constructors and utility methods for converting between
/// raw data (Map or List<Map>) and entity objects used in the domain layer.
/// Ensures smooth mapping between API response models and domain entities.
class PostModel extends Post {
  const PostModel(
      {required super.albumId,
      required super.id,
      required super.title,
      required super.url,
      required super.thumbnailUrl});

  /// Converts a map to Object
  factory PostModel.fromMap(Map<String, dynamic> map) => PostModel(
      albumId: map['albumId'],
      id: map['id'],
      title: map['title'],
      url: map['url'],
      thumbnailUrl: map['thumbnailUrl']);

  /// Converts a list of map to list of Object
  static List<PostModel> fromMapList(List<Map<String, dynamic>> mapList) =>
      mapList.map((element) => PostModel.fromMap(element)).toList();

  /// Converts a PostModel to Post entity
  Post toEntity() => Post(
      albumId: albumId,
      id: id,
      title: title,
      url: url,
      thumbnailUrl: thumbnailUrl);

  /// Converts a list of PostModel to list of Post entity
  static List<Post> toEntityList(List<PostModel> postModels) =>
      postModels.map((postModel) => postModel.toEntity()).toList();
}

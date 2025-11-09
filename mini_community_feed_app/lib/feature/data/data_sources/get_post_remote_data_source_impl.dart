import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:mini_community_feed_app/core/network/api_client.dart';
import 'package:mini_community_feed_app/feature/data/data_sources/get_post_remote_data_source.dart';
import 'package:mini_community_feed_app/feature/data/models/post_model.dart';

class GetPostRemoteDataSourceImpl extends GetPostRemoteDataSource {
  final ApiClient client;

  GetPostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getPosts() async {
    const String url = '/photos';
    final response = await client.get(url);

    // Convert to sendable data (List<Map<String, dynamic>>)
    // If your ApiClient already returns decoded JSON, skip this decode step.
    final List<dynamic> jsonList = jsonDecode(jsonEncode(response));

    // Use compute safely
    final posts = await compute(parsePostsInBackground, jsonList);

    return posts;
  }
}

/// Runs in background isolate — must be top-level
List<PostModel> parsePostsInBackground(List<dynamic> jsonList) {
  final mapped = jsonList.map((e) => e as Map<String, dynamic>).toList();
  return PostModel.fromMapList(mapped);
}

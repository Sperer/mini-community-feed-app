import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mini_community_feed_app/core/network/network_info.dart';
import 'package:mini_community_feed_app/core/typedef/typedef.dart';
import 'package:mini_community_feed_app/errors/app_exception.dart';
import 'package:mini_community_feed_app/errors/http_exception.dart';
import 'package:mini_community_feed_app/feature/data/data_sources/get_post_remote_data_source.dart';
import 'package:mini_community_feed_app/feature/data/models/post_model.dart';
import 'package:mini_community_feed_app/feature/domain/entities/post.dart';
import 'package:mini_community_feed_app/feature/domain/repositories/get_post_repository.dart';

/// Repository implementation that fetches posts from a 
/// remote data source and handles network or API exceptions.
class GetPostRepositoryImpl extends GetPostRepository {
  final GetPostRemoteDataSource getPostRemoteDataSource;
  final NetworkInfo networkInfo;
  GetPostRepositoryImpl(
      {required this.getPostRemoteDataSource, required this.networkInfo});
  @override
  ResultFuture<List<Post>> getPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final posts = await getPostRemoteDataSource.getPosts();
        return Right(PostModel.toEntityList(posts));
      } catch (e) {
        debugPrint(e.toString());
        if (e is HttpException) {
          return Left(e);
        } else if (e is AppException) {
          return Left(e);
        }
        return Left(UnknownException());
      }
    }
    return Left(NoInternetException());
  }
}

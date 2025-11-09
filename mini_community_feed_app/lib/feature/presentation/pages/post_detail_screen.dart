import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_community_feed_app/feature/presentation/Bloc/reaction/reaction_bloc.dart';
import 'package:mini_community_feed_app/feature/presentation/Bloc/reaction/reaction_event.dart';
import 'package:mini_community_feed_app/feature/presentation/Bloc/reaction/reaction_state.dart';
import 'package:shimmer/shimmer.dart';

class FullScreenImage extends StatelessWidget {
  final int id;
  final String caption;
  final String imageUrl;
  final bool isImageSuccessfullyLoaded;
  final bool isLiked;

  const FullScreenImage({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.isLiked,
    required this.caption,
    required this.isImageSuccessfullyLoaded,
  });

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Hero(
        tag: 'post_$id',
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageSection(context, screen),
              _buildCaption(context),
            ],
          ),
        ),
      ),
    );
  }

  // IMAGE SECTION
  Widget _buildImageSection(BuildContext context, Size screen) {
    return Stack(
      children: [
        _buildImage(context, screen),
        _buildBackButton(context),
        _buildLikeButton(context, screen),
      ],
    );
  }

  // NETWORK IMAGE / PLACEHOLDER
  Widget _buildImage(BuildContext context, Size screen) {
    if (!isImageSuccessfullyLoaded) {
      return Container(
        height: (screen.height * 2) / 3,
        width: double.infinity,
        color: Colors.grey[300],
        child: const Icon(Icons.broken_image, size: 60, color: Colors.grey),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.contain,
      progressIndicatorBuilder: (context, url, progress) => Shimmer.fromColors(
        baseColor: Colors.grey.shade700,
        highlightColor: Colors.grey[500]!,
        child: Container(color: Colors.grey[800]),
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey[900],
        child: const Icon(Icons.broken_image, size: 100, color: Colors.white70),
      ),
    );
  }

  // BACK BUTTON
  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      top: 30,
      left: 10,
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  // LIKE BUTTON (BlocBuilder)
  Widget _buildLikeButton(BuildContext context, Size screen) {
    return Positioned(
      top: (screen.height * 1.8) / 3,
      left: screen.width - 60,
      child: BlocBuilder<ReactionBloc, ReactionState>(
        builder: (context, state) {
          bool liked = isLiked;

          if (state is ReactionLoadedState) {
            liked = state.likedPostIds.contains(id);
          }

          return IconButton(
            icon: Icon(
              liked ? Icons.favorite_rounded : Icons.favorite_border,
              color: Colors.red,
              size: 30,
            ),
            onPressed: () {
              context.read<ReactionBloc>().add(LikeReactionEvent(id));
            },
          );
        },
      ),
    );
  }

  // CAPTION TEXT
  Widget _buildCaption(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        caption,
        textAlign: TextAlign.left,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}

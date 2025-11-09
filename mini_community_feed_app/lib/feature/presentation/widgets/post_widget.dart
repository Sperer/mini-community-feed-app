import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_community_feed_app/feature/presentation/Bloc/reaction/reaction_bloc.dart';
import 'package:mini_community_feed_app/feature/presentation/Bloc/reaction/reaction_event.dart';
import 'package:mini_community_feed_app/feature/presentation/pages/post_detail_screen.dart';
import 'package:shimmer/shimmer.dart';

class PostWidget extends StatefulWidget {
  final int id;
  final String thumbnailUrl;
  final String caption;
  final bool isLiked;

  const PostWidget({
    super.key,
    required this.id,
    required this.caption,
    required this.thumbnailUrl,
    required this.isLiked,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isImageSuccessfullyLoaded = false;
  bool isComingFromFullScreen = false;

  void _navigateToFullScreen(BuildContext context) {
    isComingFromFullScreen = true;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullScreenImage(
          id: widget.id,
          caption: widget.caption,
          imageUrl: widget.thumbnailUrl,
          isLiked: widget.isLiked,
          isImageSuccessfullyLoaded: isImageSuccessfullyLoaded,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToFullScreen(context),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 4,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageSection(),
              _buildCaptionSection(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the post image with shimmer and error handling
  Widget _buildImageSection() {
    return Hero(
      tag: 'post_${widget.id}',
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: CachedNetworkImage(
            imageUrl: widget.thumbnailUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            imageBuilder: (context, imageProvider) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!isImageSuccessfullyLoaded) {
                  setState(() => isImageSuccessfullyLoaded = true);
                }
              });
              return Image(image: imageProvider, fit: BoxFit.cover);
            },
            progressIndicatorBuilder: (context, url, progress) =>
                !isComingFromFullScreen && !isImageSuccessfullyLoaded
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey.shade400,
                        highlightColor: Colors.grey[100]!,
                        child: Container(color: Colors.grey[300]),
                      )
                    : _buildFallback(),
            errorWidget: (context, url, error) => _buildFallback()),
      ),
    );
  }

  Widget _buildFallback() => Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey[300],
        child: const Center(
          child: Icon(Icons.broken_image, size: 60, color: Colors.grey),
        ),
      );

  /// Builds caption + like button section
  Widget _buildCaptionSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Caption text
          Expanded(
            flex: 5,
            child: Text(
              widget.caption,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),

          // Like button
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(
                widget.isLiked ? Icons.favorite_rounded : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {
                context.read<ReactionBloc>().add(LikeReactionEvent(widget.id));
              },
            ),
          ),
        ],
      ),
    );
  }
}

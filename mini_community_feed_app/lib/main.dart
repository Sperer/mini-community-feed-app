import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_community_feed_app/feature/presentation/Bloc/reaction/reaction_bloc.dart';
import 'package:mini_community_feed_app/feature/service_locator.dart';
import 'package:mini_community_feed_app/feature/presentation/Bloc/post/post_bloc.dart';
import 'package:mini_community_feed_app/feature/presentation/pages/home_screen.dart';

void main() {
  setupLocator();
  return runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => PostBloc(locator())),
    BlocProvider(create: (context) => ReactionBloc())
  ], child: MiniCommunityApp()));
}

class MiniCommunityApp extends StatelessWidget {
  const MiniCommunityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}

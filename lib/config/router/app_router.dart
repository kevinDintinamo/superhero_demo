import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.screenName,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/${StoriesScreen.screenName}',
      name: StoriesScreen.screenName,
      builder: (context, state) => const StoriesScreen(),
    ),
    GoRoute(
      path: '/${ComicScreen.screenName}',
      name: ComicScreen.screenName,
      builder: (context, state) => const ComicScreen(),
    ),
  ],
);

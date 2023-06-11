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
      path: '/${ComicsScreen.screenName}',
      name: ComicsScreen.screenName,
      builder: (context, state) => const ComicsScreen(),
    ),
    GoRoute(
      path: '/${EventsScreen.screenName}',
      name: EventsScreen.screenName,
      builder: (context, state) => const EventsScreen(),
    ),
  ],
);

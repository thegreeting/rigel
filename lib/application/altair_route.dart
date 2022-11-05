import 'package:go_router/go_router.dart';

import '../presentation/page/home.page.dart';
import '../presentation/page/welcome.page.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomePage(),
      routes: [
        GoRoute(
          path: 'home',
          builder: (context, state) => const HomePage(),
        ),
      ],
    ),
  ],
);

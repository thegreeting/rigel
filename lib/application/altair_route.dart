import 'package:altair/presentation/page/compose.page.dart';
import 'package:altair/presentation/page/select_greeting_word.page.dart';
import 'package:flutter/material.dart';
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
          pageBuilder: (context, state) => const MaterialPage<HomePage>(
            child: HomePage(),
            fullscreenDialog: true,
          ),
        ),
        GoRoute(
          path: 'select_greeting_word',
          builder: (context, state) => const SelectGreetingWordPage(),
        ),
        GoRoute(
          path: 'compose',
          builder: (context, state) => const ComposePage(),
        ),
      ],
    ),
  ],
);

import 'package:altair/presentation/page/compose.page.dart';
import 'package:altair/presentation/page/proof_of_humanity.page.dart';
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
          path: 'proof_of_humanity',
          builder: (context, state) => const WorldIdPage(),
        ),
        GoRoute(
          path: 'home',
          pageBuilder: (context, state) => const MaterialPage<HomePage>(
            child: HomePage(),
            fullscreenDialog: true,
          ),
        ),
        GoRoute(
          path: 'campaigns/:campaignId/select_greeting_word',
          builder: (context, state) => SelectGreetingWordPage(
            campaignId: state.params['campaignId']!,
          ),
        ),
        GoRoute(
          path: 'campaigns/:campaignId/compose',
          builder: (context, state) => ComposePage(
            campaignId: state.params['campaignId']!,
          ),
        ),
      ],
    ),
  ],
);

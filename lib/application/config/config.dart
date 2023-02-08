import 'package:package_info/package_info.dart';

import '../../logger.dart';
import '../../util/flavor.provider.dart';
import 'status.dart';

Future<void> configureRigel(Flavor flavor) async {
  final packageInfo = await PackageInfo.fromPlatform();
  App.version = packageInfo.version;
  App.buildNumber = packageInfo.buildNumber;
  logger
    ..info('App.version: ${App.version}(${App.buildNumber})')
    ..info('App.flavor: $flavor');
}

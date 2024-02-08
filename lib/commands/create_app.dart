import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:cli_util/cli_logging.dart';
import 'package:flutter_ngine_cli/utils/utils.dart';

class CreateApp extends Command {
  final Logger logger = Logger.standard();

  @override
  ArgParser get argParser => ArgParser()

    /// Gets app name from the argument
    ..addOption(
      'name',
      abbr: 'n',
      help: 'The name of the app to create.',
      valueHelp: 'sample_flutter_app',
    )

    /// Gets organization name from the argument
    ..addOption(
      'org',
      abbr: 'o',
      help: 'The organization to use for the app.',
      valueHelp: 'com.example',
      defaultsTo: 'com.example',
    );

  @override
  String get description => 'Creates app with default template';

  @override
  String get name => 'create';

  /// This [run()] will be the default method to run when "ngine create" executed.
  @override
  Future<void> run() async {
    /// Gets all arguments passed from the command.
    final String? appName = argResults?['name'] as String?;
    final String? orgName = argResults?['org'] as String?;

    /// Returns error message if app name is not provided
    if (appName == null || appName.isEmpty) {
      print('Please provide a name for your app.');
      return;
    }

    /// Returns error message if organization name is empty or not valid.
    if (orgName == null || orgName.isEmpty || orgName.split('.').length != 2) {
      print('Please provide an organization name for your app (ex. com.example).');
      return;
    }

    /// Creates flutter app.
    _createApp(appName, orgName);
  }

  void _createApp(String appName, String orgName) async {
    final Progress createAppProgress = logger.progress('Creating app $appName');

    await Process.run(flutterPath, ['create', appName, '--empty', '--org', orgName, '--verbose']);

    createAppProgress.finish(showTiming: true);
  }
}

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
      valueHelp: 'sample',
    )

    /// Template to be used  for the app
    ..addOption(
      'template',
      abbr: 't',
      help: 'The template to be used for the app.',
      valueHelp: 'getx, provider',
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
    final String? templateName = argResults?['template'] as String?;

    /// Returns error message if app name is not provided
    if (appName == null || appName.isEmpty) {
      print('Please provide a name for your app.');
      return;
    }

    /// Returns error message if organization name is empty or not valid.
    if (orgName == null || orgName.split('.').length != 2) {
      print('Please provide a proper organization name for your app (ex. com.example).');
      return;
    }

    if (templateName == null || templateName.isEmpty) {
      print('Please provide a template to be used for your app.');
      return;
    } else {
      List<String> validTemplateNames = ['getx', 'provider'];

      if (validTemplateNames.contains(templateName.toLowerCase())) {
        // Proceed with the template logic
      } else {
        print('Given template is not valid, please try again. Example: (getx, provider).');
        return;
      }
    }

    /// Creates flutter app.
    await _createApp(appName, orgName);

    /// Gets template directory
    final String? templatePath = await _getTemplateDirectory();

    /// Checks of the template path is null. Returns error if true.
    if (templatePath == null) {
      logger.stdout('Template path is null');
      return;
    }

    await copyTemplate(templatePath, appName);
  }

  Future<void> _createApp(String appName, String orgName) async {
    final Progress createAppProgress = logger.progress('Creating app $appName');

    await Process.run(flutterPath, ['create', appName, '--empty', '--org', orgName, '--verbose']);

    createAppProgress.finish(showTiming: true);
  }

  Future<String?> _getTemplateDirectory() async {
    final Progress copyTemplateProgress = logger.progress('Getting template directory...');
    String? templatePath = await getTemplateDir(Template.getx);

    copyTemplateProgress.finish(showTiming: true);

    return templatePath;
  }
}

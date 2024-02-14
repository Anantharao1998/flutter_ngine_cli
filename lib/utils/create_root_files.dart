import 'dart:io';

import 'package:io/io.dart';

Future<void> createRootFiles(String templatePath, String appName) async {
  File analysisOptions = File('analysis_options.yaml');
  await analysisOptions.writeAsString(getAnalysisOptionsText(templatePath: templatePath), mode: FileMode.write);

  File pubspecLock = File('pubspec.lock');
  if (pubspecLock.existsSync()) await pubspecLock.delete();

  File pubspec = File('pubspec.yaml');
  await pubspec.writeAsString(getPubspecText(appName, templatePath: templatePath), mode: FileMode.write);

  File readme = File('README.md');
  await readme.writeAsString(getReadmeText(appName, templatePath: templatePath), mode: FileMode.write);

  await copyPath('$templatePath/assets/images', 'assets/images');

  Directory runDirectory = Directory('$templatePath/runConfigurations');
  Directory vsCodeDirectory = Directory('$templatePath/.vscode');

  if (runDirectory.existsSync()) {
    await copyPath('$templatePath/runConfigurations', '.idea/runConfigurations');
  }

  if (vsCodeDirectory.existsSync()) {
    await copyPath('$templatePath/.vscode', '.vscode');

    File entity = File('.vscode/launch.json');
    var content = await entity.readAsString();
    var modifiedContent = content.replaceAll('internal-', '');
    await entity.writeAsString(modifiedContent);
  }
}

String getPubspecText(String appName, {String? templatePath}) => File('$templatePath/pubspec.yaml')
    .readAsStringSync()
    .replaceAll(
      'juno_provider_base_project',
      appName.toLowerCase(),
    )
    .replaceAll(
      'juno_getx_base_project',
      appName.toLowerCase(),
    );

String getAnalysisOptionsText({String? templatePath}) => File('$templatePath/analysis_options.yaml').readAsStringSync();

String getReadmeText(String appName, {String? templatePath}) => File('$templatePath/README.md')
    .readAsStringSync()
    .replaceAll(
      'juno_provider_base_project',
      appName.toLowerCase(),
    )
    .replaceAll(
      'juno_getx_base_project',
      appName.toLowerCase(),
    );

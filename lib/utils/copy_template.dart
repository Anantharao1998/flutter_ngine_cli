import 'dart:io';
import 'dart:isolate';

import 'package:io/io.dart';

/*
It takes a nullable Template object as an argument.
It defines a packageUri pointing to 'package:flutter_ngine_cli/'.
It resolves the package URI to get the absolute URI using Isolate.resolvePackageUri.
It awaits the resolution to get the absolute URI.
It converts the absolute URI to a Directory object.
It checks if the directory exists.
If the directory exists, it calls getTemplateDirectory function passing the absolute URI and the template object.
It returns the path of the template directory if it exists, otherwise, it returns null.
*/
Future<String?> getTemplateDir(Template? template) async {
  final packageUri = Uri.parse('package:flutter_ngine_cli/');

  final future = Isolate.resolvePackageUri(packageUri);

  final absoluteUri = await future;

  final directory = Directory.fromUri(absoluteUri!);

  if (directory.existsSync()) {
    Directory templateDirectory = getTemplateDirectory(absoluteUri, template: template);

    return templateDirectory.path;
  }
  return null;
}

/*
It takes an absolute URI and an optional Template object.
It determines the template directory based on the provided template.
The directory returned will be based on Template.
 */
Directory getTemplateDirectory(Uri absoluteUri, {Template? template}) {
  switch (template) {
    case Template.getx:
      return Directory.fromUri(
        absoluteUri.resolve('../getx_template'),
      );
    case Template.provider:
      return Directory.fromUri(
        absoluteUri.resolve('../provider_template'),
      );
    default:
      return Directory.fromUri(
        absoluteUri.resolve('../getx_template'),
      );
  }
}

enum Template { getx, provider }

Future<void> copyTemplate(String templatePath, String appName) async {
  Directory.current = Directory(appName);
  await copyPath('$templatePath/lib', 'lib');

  try {
    // Replace all instances of flutterfast with the app name
    final directory = Directory('lib');

    await for (var entity in directory.list(recursive: true, followLinks: false)) {
      if (entity is File) {
        var content = await entity.readAsString();
        var modifiedContent = content.replaceAll('juno_provider_base_project', appName).replaceAll('juno_getx_base_project', appName);
        await entity.writeAsString(modifiedContent);
      }
    }
  } catch (e) {
    stderr.writeln(e);
  }
}

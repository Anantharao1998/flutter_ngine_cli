import 'package:args/command_runner.dart';
import 'package:flutter_ngine_cli/commands/create_app.dart';

void main(List<String> arguments) {
  CommandRunner('ngine', 'CLI tool to create flutter apps with Ngine templates')
    ..addCommand(CreateApp())
    ..run(arguments);
}

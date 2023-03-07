import 'package:adf_cli/commands/students/students_command.dart';
import 'package:args/args.dart';
import 'package:args/command_runner.dart';

void main(List<String> arguments) {
  CommandRunner('ASD CLI', 'ADF CLI')
    ..addCommand(StudentsCommand())
    ..run(arguments);

}




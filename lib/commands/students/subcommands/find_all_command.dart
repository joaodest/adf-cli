import 'dart:io';

import 'package:adf_cli/repositories/student_dio_repository.dart';
import 'package:adf_cli/repositories/student_repository.dart';
import 'package:args/command_runner.dart';

class FindAllCommand extends Command {
  final StudentDioRepository repository;

  FindAllCommand(this.repository);

  @override
  String get description => 'Find all Students';

  @override
  String get name => 'findAll';

  @override
  void run() async {
    print('Aguarde... Buscando alunos...');
    final students = await repository.findAll();
    print('Apresentar também os cursos? S/N');

    final showCourses = stdin.readLineSync();
    print('-------------------------------');
    print('Alunos:');
    print('-------------------------------');
    for (var student in students) {
      if (showCourses?.toLowerCase() == 's') {
        print(
            '${student.id} - ${student.name} ${student.courses.where((course) => course.isStudent)
            .map((e) => e.nameCourse).toList()}');
      } else {
        print('${student.id} - ${student.name}');
      }
    }
  }
}

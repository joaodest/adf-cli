import 'package:adf_cli/repositories/student_dio_repository.dart';
import 'package:args/command_runner.dart';

import '../../../repositories/student_repository.dart';

class FindByIdCommand extends Command {
  final StudentDioRepository repository;

  FindByIdCommand(this.repository) {
    argParser.addOption('id', help: 'Student ID', abbr: 'i');
  }

  @override
  String get description => 'Find Student by ID';

  @override
  String get name => 'byId';

  @override
  Future<void> run() async {
    if (argResults?['id'] == null) {
      print('Por favor, envie o ID do aluno com o comando --id=0 ou -i 0');
      return;
    }
    final id = int.parse(argResults?['id']);

    print('Aguarde... Buscando dados...');
    final student = await repository.findById(id);
    print('-------------------------------');
    print('Aluno: ${student.name}:');
    print('-------------------------------');
    print('Nome: ${student.name}:');
    print("Idade: ${student.age ?? 'Não informado'}");
    print("Curso: ");
    student.nameCourses.forEach(print);
    print('Endereço: ');
    print('    ${student.address.street} ${student.address.zipCode}');
  }
}

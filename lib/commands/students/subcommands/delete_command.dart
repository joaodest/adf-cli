import 'dart:io';

import 'package:adf_cli/repositories/student_dio_repository.dart';
import 'package:args/command_runner.dart';

import '../../../repositories/student_repository.dart';

class DeleteCommand extends Command {
  final StudentDioRepository repository;

  @override
  String get description => 'Delete student by ID';

  @override
  String get name => 'delete';

  DeleteCommand(this.repository) {
    argParser.addOption('id', help: 'Student ID', abbr: 'i');
  }
  @override
  Future<void> run() async {
    final id = int.tryParse(argResults?['id']);
    if (id == null) {
      print('Por favor, informe o ID de um aluno com o comando --id=0 ou -i 0');
      return;
    }
    print('Aguarde....');
    final student = await repository.findById(id);

    print("Deseja mesmo deletar o aluno ${student.name}? S/N");

    final delete = stdin.readLineSync();

    if (delete?.toLowerCase() == 's') {
      await repository.deleteById(id);
      print("Deletando aluno");
      print('-------------------------------');     
      print('-------------------------------');
      print("Aluno deletado com sucesso!");
      print('-------------------------------');
    } else {
      print('-------------------------------');
      print("Operação revertida!");
      print('-------------------------------');
    }
  }
}

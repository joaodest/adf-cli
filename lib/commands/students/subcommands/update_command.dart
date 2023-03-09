// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:adf_cli/models/address.dart';
import 'package:adf_cli/models/city.dart';
import 'package:adf_cli/models/phone.dart';
import 'package:adf_cli/models/students.dart';
import 'package:adf_cli/repositories/student_dio_repository.dart';
import 'package:args/command_runner.dart';

import '../../../repositories/product_repository.dart';
import '../../../repositories/student_repository.dart';

class UpdateCommand extends Command {
  final StudentDioRepository studentRepository;
  final productRepository = ProductDioRepository();

  @override
  String get description => 'Update Student';

  @override
  String get name => 'update';

  UpdateCommand(this.studentRepository) {
    argParser.addOption('file', help: 'Path of the csv file', abbr: 'f');
    argParser.addOption('id', help: 'Student ID', abbr: 'i');
  }
  @override
  void run() async {
    print('Aguarde...');
    final id = argResults?['id'];
    final filePath = argResults?['file'];

    if (id == null) {
      print('Preencha o ID do aluno corretamente com o comando --id=0 ou -i 0');
      return;
    }

    final students = File(filePath).readAsLinesSync();
    print('Aguarde, atualizando dados do aluno');
    print('-------------------------------');

    if (students.length > 1) {
      print('Por favor, informe somente um aluno no arquivo $filePath');
      return;
    } else if (students.isEmpty) {
      print('Por favor, informe um aluno no arquivo $filePath');
      return;
    }
    var student = students.first;

    final studentData = student.split(';');
    final courseCsv = studentData[2].split(',').map((e) => e.trim()).toList();

    final courseFutures = courseCsv.map((c) async {
      final course = await productRepository.findByName(c);
      course.isStudent = true;
      return course;
    }).toList();

    final courses = await Future.wait(courseFutures);

    final studentModel = Students(
      id: int.parse(id),
      name: studentData[0],
      nameCourses: courseCsv,
      age: int.tryParse(studentData[1]),
      courses: courses,
      address: Address(
        street: studentData[3],
        number: int.parse(studentData[4]),
        zipCode: studentData[5],
        city: City(id: 1, cityName: studentData[6]),
        phone: Phone(
          ddd: int.parse(studentData[7]),
          phone: studentData[8],
        ),
      ),
    );

    await studentRepository.update(studentModel);

    print('-------------------------------');
    print('Aluno atualizado com sucesso');
  }
}
